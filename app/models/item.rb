class Item < ApplicationRecord
  # Associations
  belongs_to :user
  has_one_attached :image

  # has_one :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :days_to_ship
  has_one    :purchase

  with_options numericality: { other_than: 1, message: 'は選択してください' } do
    validates :category_id
    validates :condition_id
    validates :shipping_cost_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

  # Validations
  with_options presence: true do
    validates :image
    validates :item_name
    validates :description
    validates :price
  end

  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: '価格は半角かつ¥300から¥9,999,999の間で入力して下さい' }
end
