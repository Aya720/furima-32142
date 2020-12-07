class OrdersController < ApplicationController
  def index
    # binding.pry で一度止めてみると、何が必要とされているかが、ターミナルで確認できる。
    # 今回は外部キーで指定したモデルからidを取り出すので、:id と入れるだけでは読み取ってもらえなかった
    @item = Item.find(params[:item_id])
  end
end
