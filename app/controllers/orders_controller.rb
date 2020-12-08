class OrdersController < ApplicationController
  def index
    # binding.pry で一度止めてみると、何が必要とされているかが、ターミナルで確認できる。
    # 今回は外部キーで指定したモデルからidを取り出すので、:id と入れるだけでは読み取ってもらえなかった
    @item = Item.find(params[:item_id])
    # いつもnewアクションでしてたこと。箱を作るだけ。
    @purchase = Purchase.new
  end
 
  def create
    # これを記述しないと、ストロングパラメータでmergeしたitem.id(params[:item_id])はどれ？、となる。
    # ここで呼んできたidがスロトングパラメータに入り保存されると共に、formオブジェクトのattr_accessorも値を加える
    item = Item.find(params[:item_id])
    @purchase = Purchase.new(purchase_params)
     if @purchase.save
       redirect_to action: :index
     else
       render action: :new
     end
  end

  private
  # 全てのストロングパラメーターを1つに統合
 def purchase_params
  params.require(:purchase).permit(:zip, :prefecture_id, :city, :street, :apartment, :phone).merge(item_id: params[:item_id],user_id: current_user.id)
 end
end