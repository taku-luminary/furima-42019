require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_shipping = FactoryBot.build(:purchase_shipping, user_id: @user.id, item_id: @item.id)
  end

  context '購入できるとき' do
    it '全ての項目が正しく入力されていれば購入できる' do
      expect(@purchase_shipping).to be_valid
    end

    it '建物名が空でも購入できる' do
      @purchase_shipping.building = ''
      expect(@purchase_shipping).to be_valid
    end
  end

  context '購入できないとき' do
    it '郵便番号が空では購入できない' do
      @purchase_shipping.zip_code = ''
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("Zip code can't be blank")
    end

    it '郵便番号が正しい形式でないと購入できない' do
      @purchase_shipping.zip_code = '1234567'
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include('Zip code は「3桁-4桁」の形式で入力してください')
    end

    it '都道府県が必須であること。' do
      @purchase_shipping.prefecture_id = '1'
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '市区町村が空では購入できない' do
      @purchase_shipping.city = ''
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("City can't be blank")
    end

    it '番地が空では購入できない' do
      @purchase_shipping.street_address = ''
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("Street address can't be blank")
    end

    it '電話番号が空では購入できない' do
      @purchase_shipping.phone_number = ''
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号がハイフン付きだと購入できない' do
      @purchase_shipping.phone_number = '090-1234-5678'
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include('Phone number はハイフンなしの10〜11桁の半角数字で入力してください')
    end

    it 'tokenが空では購入できない' do
      @purchase_shipping.token = ''
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("Token can't be blank")
    end

    it '電話番号が9桁以下では購入できない' do
      @purchase_shipping.phone_number = '090123456'
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include('Phone number はハイフンなしの10〜11桁の半角数字で入力してください')
    end

    it '電話番号が12桁以上では購入できない' do
      @purchase_shipping.phone_number = '090123456789'
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include('Phone number はハイフンなしの10〜11桁の半角数字で入力してください')
    end

    it 'user_idが空では購入できない' do
      @purchase_shipping.user_id = nil
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idが空では購入できない' do
      @purchase_shipping.item_id = nil
      @purchase_shipping.valid?
      expect(@purchase_shipping.errors.full_messages).to include("Item can't be blank")
    end
  end
end
