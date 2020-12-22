FactoryBot.define do
  factory :purchase do
    zip              { '123-4567' }
    prefecture_id    { 1 }
    city             { 'aaaaa' }
    street           { 'aaaaa' }
    apartment        { 'aaaaa' }
    phone            { '11111111111' }
    token            {"tok_abcdefghijk00000000000000000"}

    # 外部キーを直接記述する形は好ましくない。purchase_spec.rbのbeforeにまとめよう。
    association :user_id, factory: :user
    association :item_id, factory: :item
    
    # 違う記述方法 以下のように書いて、
    # association :user
    # association :item

    # rspecでは、以下のように書く。formオブジェクトのモデルではアソシエーションを組むことができないので、ここで呼び出して、紐付けるカラムを指定する
    # @purchase = FactoryBot.build(:purchase, user_id: @user.id,item_id: @item.id)
    # user_id {}
    # user =  FactoryBot.create(:user)
    # user.id
    # user_id {user.id}
  end
end