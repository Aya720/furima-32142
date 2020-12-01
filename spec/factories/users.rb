FactoryBot.define do
  factory :user do
    nickname              { 'aaa' }
    email                 { 'aaa@aaa' }
    password              { 'a12345' }
    password_confirmation { password }
    first_name            { '太郎' }
    last_name             { '山田' }
    first_name_kana       { 'タロウ' }
    last_name_kana        { 'ヤマダ' }
    birthday              { '2000-01-01' }
  end
end
