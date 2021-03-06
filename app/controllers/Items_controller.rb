class ItemsController < ApplicationController
  # deviseのメソッド。before_actionで呼び出すことで、アクションを実行する前にログインしていなければログイン画面に遷移させられる。
  before_action :authenticate_user!, only: [:new, :edit]
  # 編集と詳細は誰のページなのか
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit]
  before_action :sold_out_item, only: [:edit]
  def index
    # includesメソッド モデル.includes(:アソシエーションを組んでいるモデル):引数に指定された関連モデルを1度のアクセスでまとめて取得。処理の回数を減らしてパフォーマンスが著しく下がることを防ぐ。
    # itemsテーブルの全ての値を取得してくれる = .allの記述省略可
    # .includesで指定したモデルからアソシエーションが組んだ外部キーの値を持ってくる
    # orderメソッド .order("並び替えの基準となるカラム 並び順") 新しいものから古いもの＝DESC
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    # 商品出品ページで入力されたものを保存
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    unless current_user == @item.user
      redirect_to item_path(@item.id)
    else @item.destroy
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :state_id, :postage_id, :prefecture_id, :shipping_date_id, :price, :image).merge(user_id: current_user.id)
  end

  # 例えばshowのviewファイルで@itemを使って、userIdを取得できているのは⬇︎ここで値を変数化して使える状態にしているから
  # モデル名.find：主キーに対応するレコードを取り出すことができる
  # paramsとはRailsで送られてきた値を受け取るためのメソッド。params[:カラム名]で値を受け取ることができる。
  def set_item
    # paramsはユーザーが入力した値を格納しているもの、と言う認識があったけれど、パスではrailsが用意したidの情報を格納するのに使われている
    @item = Item.find(params[:id])
    # 
    # @order = Order.find_by(item_id: params[:id])
  end

  def move_to_index
    redirect_to action: :index unless current_user == @item.user
  end

  def sold_out_item
    redirect_to root_path if @item.order.present?
  end
end
