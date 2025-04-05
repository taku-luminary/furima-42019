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

  # validates :price, format: { with: /\A[0-9]+\z/, message: 'Price 価格は半角数値で入力してください' }
  # 全角だと出品できないエラーと価格範囲指定のエラーコードをマージしている理由
  # FactoryBotで生成された @item オブジェクトの price が意図せず数値の 0 で初期化されていたため、テスト内で全角数字 '１０００' を代入する前に数値型になっており、format バリデーションよりも先に numericality バリデーションが働き、期待される「半角数値で入力してください」のエラーメッセージではなく、数値範囲のエラーメッセージが表示されてしまうため
end
