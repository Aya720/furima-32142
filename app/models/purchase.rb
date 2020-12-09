class Purchase # Formオブジェクトには < ApplicationRecord の記述は不要。使わない。元々あるけど消す。

  # Active Record( MVCで言うところのM、つまりモデル)を継承しているものではないからアソシエーションは組まない!
  include ActiveModel::Model

  # たとえmergeしてる内容でも⬇️こことストロングパラメータの記述はイコールの関係である必要がある。フォームから保存する値とイコール、なのではない。
  # じゃないと、PCがストロングパラメータを呼んだ時に 聞いてないから知らない、になりエラーが出される。
  attr_accessor :zip, :prefecture_id, :city, :street, :apartment, :phone, :item_id, :user_id, :item_image

  with_options presence: true do
  # 郵便番号にはハイフンが必要
  validates :zip, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
  validates :prefecture_id, numericality: { other_than: 0 }
  validates :city
  validates :street
  # 電話番号にはハイフンは不要で、11桁以内
  validates :phone, format: { with: /\A\d{11}\z/ }
  end

  def save
    # Address.create内の order_id: order.id のorderを示してあげる必要がある
    # ここで指定して保存している値は、attr_accessor で許可したカラムのkeyとイコールの関係だから、order.idの時みたくuserという変数に値を代入する必要はないし、そもそもuserはこのページで登録されるものじゃない。current_userがuser_idの役割を担っているはず。
    order = Order.create( user_id: user_id, item_id: item_id)
    
    # 住所
    Address.create( zip: zip, prefecture_id: prefecture_id, city: city, street: street, apartment: apartment, phone: phone, order_id: order.id)
  end
end
