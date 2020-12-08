class Purchase # Formオブジェクトには < ApplicationRecord の記述は不要。使わない。元々あるけど消す。

  # Active Record( MVCで言うところのM、つまりモデル)を継承しているものではないからアソシエーションは組まない!
  include ActiveModel::Model

  # たとえmergeしてる内容でも⬇️こことストロングパラメータの記述はイコールの関係である必要がある。フォームから保存する値とイコール、なのではない。
  # じゃないと、PCがストロングパラメータを呼んだ時に 聞いてないから知らない、になりエラーが出される。
  attr_accessor :zip, :prefecture_id, :city, :street, :apartment, :phone, :item_id, :user_id

  validates :zip, :prefecture_id, :city, :street, :phone, presence: true
  # 電話番号、郵便番号は半角数字
  #validates :phone, :zip, format: { with: /\A[0-9]+\z/ }
  # 番地、建物名は漢字・ひらがな・カタカナ・半角英数字
  #validates :city, :street, :apartment, format: { with: }
  # 郵便番号にはハイフンが必要
  validates :zip, format: { with: /\A\d{3}\-?\d{4}\z/ }
  # 電話番号にはハイフンは不要で、11桁以内
  validates :phone, format: { with: /\A\d{11}\z/ }
  # 都道府県・配送料負担に関するバリデーション
  validates :prefecture_id, :postage_id, numericality: { other_than: 0 }

  def save

    # Address.create内の order_id: order.id のorderを示してあげる必要がある
    # ここで指定して保存している値は、attr_accessor で許可したカラムのkeyとイコールの関係だから、order.idの時みたくuserという変数に値を代入する必要はないし、そもそもuserはこのページで登録されるものじゃない。current_userがuser_idの役割を担っているはず。
    order = Order.create( user_id: user_id, item_id: item_id)
    
    # 住所
    Address.create( zip: zip, prefecture_id: prefecture_id, city: city, street: street, apartment: apartment, phone: phone, order_id: order.id)
  end

end
