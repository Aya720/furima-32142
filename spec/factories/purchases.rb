FactoryBot.define do
  factory :purchase do
    zip              { '123-4567' }
    prefecture_id    { 1 }
    city             { 'aaaaa' }
    street           { 'aaaaa' }
    phone            { '11111111111' }
    token            {"tok_abcdefghijk00000000000000000"}
  end
end