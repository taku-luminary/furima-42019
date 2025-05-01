class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :items
  has_many :purchases
  # has_many :purchases

  # Validations
  validates :nick_name, :first_name, :family_name, :first_name_kana, :family_name_kana, :birthday, presence: true
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'は半角の英字と数字の両方を含めて設定してください' }
  validates :family_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
  validates :family_name_kana, presence: true, format: { with: /\A[ァ-ンー]+\z/, message: 'は全角カタカナで入力してください' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ンー]+\z/, message: 'は全角カタカナで入力してください' }
end
