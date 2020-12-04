FactoryBot.define do
  factory :item do
    name                   { 'aaa' }
    detail                 { 'aaa' }
    # カラムの型がintegerの場合は’’付けない
    # ActiveHashで作ったデータを格納しているカラムには、「そのデータが入っているもの」とみなす。associationを組むと逆にデータが生成されてしまうので良くない
    category_id            { 1 }
    state_id               { 1 }
    postage_id             { 1 }
    prefecture_id          { 1 }
    shipping_date_id       { 1 }
    price                  { 3000 }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/sample.jpg'), filename: 'sample.jpg')
    end
  end
end
