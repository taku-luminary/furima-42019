class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :zip_code, :prefecture_id, :city, :street_address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :zip_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「3桁-4桁」の形式で入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'はハイフンなしの10〜11桁の半角数字で入力してください' }
    validates :token
    validates :user_id
    validates :item_id
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Shipping.create(zip_code: zip_code, prefecture_id: prefecture_id, city: city, street_address: street_address, building: building,
                    phone_number: phone_number, purchase_id: purchase.id)
  end
end
