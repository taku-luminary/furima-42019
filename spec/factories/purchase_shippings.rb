FactoryBot.define do
  factory :purchase_shipping do
    zip_code { '123-4567' }
    prefecture_id { 2 }
    city { 'テスト市' }
    street_address { '1-1' }
    building { 'テストビル101' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
