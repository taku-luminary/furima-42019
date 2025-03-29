FactoryBot.define do
  factory :user do
    nick_name { Faker::Name.initials(number: 2) }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name { '太郎' }
    family_name { '山田' }
    first_name_kana { 'タロウ' }
    family_name_kana { 'ヤマダ' }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
