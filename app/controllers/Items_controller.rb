class ItemsController < ApplicationController
  # deviseのメソッド。before_actionで呼び出すことで、アクションを実行する前にログインしていなければログイン画面に遷移させられる。
  before_action :authenticate_user!, only: [:new]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :state_id, :postage_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end
end
