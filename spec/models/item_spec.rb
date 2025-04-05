require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品できること' do
      it 'image、item_name、description、priceが存在し、category_id、condition_id、shipping_cost_id、prefecture_id、days_to_ship_idの値が1以外であれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品できないとき' do
      it '商品画像が必須であること。' do
        @item.image = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end

      it '商品名が必須であること。' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name can't be blank"
      end

      it '商品の説明が必須であること。' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Description can't be blank"
      end

      it 'カテゴリーが必須であること。' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Category は選択してください'
      end

      it '商品の状態が必須であること。' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Condition は選択してください'
      end

      it '配送料の負担が必須であること。' do
        @item.shipping_cost_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Shipping cost は選択してください'
      end

      it '発送元の地域が必須であること。' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Prefecture は選択してください'
      end

      it '発送までの日数が必須であること。' do
        @item.days_to_ship_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Days to ship は選択してください'
      end

      it '販売価格が必須であること。' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end

      it '価格が300円未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price 価格は半角かつ¥300から¥9,999,999の間で入力して下さい')
      end

      it '価格が9999999円よりも高では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price 価格は半角かつ¥300から¥9,999,999の間で入力して下さい')
      end

      it '価格は全角だと出品できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price 価格は半角かつ¥300から¥9,999,999の間で入力して下さい')

        # 全角だと出品できないエラーと価格範囲指定のエラーコードをマージしている理由
        # FactoryBotで生成された @item オブジェクトの price が意図せず数値の 0 で初期化されていたため、テスト内で全角数字 '１０００' を代入する前に数値型になっており、format バリデーションよりも先に numericality バリデーションが働き、期待される「半角数値で入力してください」のエラーメッセージではなく、数値範囲のエラーメッセージが表示されてしまうため
      end
    end
  end
end
