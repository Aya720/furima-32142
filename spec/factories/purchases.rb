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
  end
end