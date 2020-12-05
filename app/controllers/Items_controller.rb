class ItemsController < ApplicationController
  # deviseのメソッド。before_actionで呼び出すことで、アクションを実行する前にログインしていなければログイン画面に遷移させられる。
  before_action :authenticate_user!, only: [:new]

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

  private

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :state_id, :postage_id, :prefecture_id, :shipping_date_id, :price, :image).merge(user_id: current_user.id)
  end
end
