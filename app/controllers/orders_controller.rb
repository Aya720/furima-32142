class OrdersController < ApplicationController
  before_action :get_id, only: [:index, :create]
  before_action :authenticate_user!, only: [:index]
  before_action :move_to_index, only: [:index]
  # before_action :sold_out_item, only: [:index]

  def index
    # binding.pry で一度止めてみると、何が必要とされているかが、ターミナルで確認できる。
    # 今回は外部キーで指定したモデルからidを取り出すので、:id と入れるだけでは読み取ってもらえなかった
    # @item = Item.find(params[:item_id])

    # いつもnewアクションでしてたこと。箱を作るだけ。
    @purchase = Purchase.new
  end
 
  def create
    # これを記述しないと、ストロングパラメータでmergeしたitem.id(params[:item_id])はどれ？、となる。
    # ここで呼んできたidがスロトングパラメータに入り保存されると共に、formオブジェクトのattr_accessorにもkeyを加える
    # 保存しなくともcreateアクションで処理をする時にpcの処理はindexの@itemの存在が気になるらしい。これを示さないとエラーになる。
    # @item = Item.find(params[:item_id])

    @purchase = Purchase.new(purchase_params)
     if @purchase.valid?
      # ここではバリデーションを正常に通過した時のみに、決済処理が行われるようにする
      # 読みやすくするためにリファクタリング。プライベートでメソッド定義
      pay_item
       @purchase.save
       redirect_to root_path
     else
       # render action: :index  と記述すると、actionのindexを通ってindex.erbに戻るよ、ということになる
       # render 'index'  だと、createアクションで読み込まれた情報を持って、indexに戻るので、結果保存できない状態の時に、それをエラーとして読み取ってエラー表示してくれる。
       render 'index'
     end
  end

  private
  def get_id
    @item = Item.find(params[:item_id])
  end

  # 全てのストロングパラメーターを1つに統合
  def purchase_params
    # merge:ユーザから受け取ったparamsにはないけれども、レコード作成時に追加したい値がある場合はmergeメソッドで含めることができる。パラメータ以外に含めたい値がある時、使う
    params.require(:purchase).permit(:zip, :prefecture_id, :city, :street, :apartment, :phone).merge(item_id: params[:item_id],user_id: current_user.id, token: params[:token])
  end

  def pay_item
      # 決算で使う値はここに全ていれる。※保存するものではないのでformオブジェクトには入れない
      # priceを取得するためここでもitemの情報を取得させたい
      # @item = Item.find(params[:item_id])   pay_itemメソッドを呼び出すcreateアクションでbefore_actionにてget_idメソッドを呼び出しているので記述はしなくてok

      # 「payjp」が提供する、Payjpクラスのapi_keyというインスタンスに秘密鍵を代入するけど、公開してはいけないため、環境変数にいれる。
      # 「APIの鍵情報は公開してはいけない」
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      # 決済に必要な情報はGemが提供する、Payjp::Charge.createというクラスおよびクラスメソッドを使用
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: purchase_params['token'],    # トークン化されたカード情報が入る
        currency: 'jpy'                 # 通貨の種類（日本円）を指定
      )
  end

  def move_to_index
    redirect_to root_path if current_user == @item.user || @item.order.present?
  end

  # def sold_out_item
    # redirect_to root_path if @item.order.present?
  # end
end