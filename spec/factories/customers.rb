FactoryBot.define do
  factory :customer do
    last_name { "徳川" }
    first_name { "家康" }
    last_name_kana { "トクガワ" }
    first_name_kana { "イエヤス" }
    postcode { "5672319" }
    address { "江戸幕府" }
    tel { "09098783432" }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    withdrawal_status { "false" }
  end
end