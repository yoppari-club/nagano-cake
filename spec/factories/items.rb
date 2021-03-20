FactoryBot.define do
  factory :candy, class: Item do
    name { "キャンディ" }
    description { Faker::Lorem.characters(number:20) }
    price_excluding_tax { 300 }
    image_id { Faker::Lorem.characters(number:20) }
    genre_id { 1 }
    sales_status { true }
  end
end