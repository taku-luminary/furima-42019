FactoryBot.define do
  factory :item do
    association :user

    item_name { 'テスト商品' }
    description { 'これはテスト用の商品説明です。' }
    price { 1000 }

    category_id { 2 }
    condition_id { 2 }
    shipping_cost_id { 2 }
    prefecture_id { 2 }
    days_to_ship_id { 2 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
