FactoryBot.define do
  factory :order do
    customer_id { 1 }
    total_payment { 300 }
    payment_option { 0 }
    shipping_fee { 800 }
    shipping_address { "岡山県桃太郎市" }
    shipping_postcode { "2345678" }
    shipping_name { "鬼ヶ島102" }
    order_status { 0 }
  end
end
