require 'rails_helper'

require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nick_name, first_name, family_name, first_name_kana, family_name_kana, birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが必須であること。' do
        @user.nick_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nick name can't be blank"
      end
      it 'eメールアドレスが必須であること。' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'メールアドレスが一意性であること。' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、@を含む必要があること。' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること。' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは、数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角の英字と数字の両方を含めて設定してください')
      end
      it 'パスワードは、英字のみでは登録できないこと' do
        @user.password = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角の英字と数字の両方を含めて設定してください')
      end
      it 'パスワードは、全角を含むと登録できないこと' do
        @user.password = '123456aａ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角の英字と数字の両方を含めて設定してください')
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '名字が空だと登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it '名前が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名字(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.family_name = '1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it '名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.first_name = '1'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it '名字カナ(全角)は、必須であること。' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it '名前カナ(全角)は、必須であること。' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '名字カナ(全角)は、必須であること。' do
        @user.family_name_kana = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana は全角カタカナで入力してください')
      end
      it '名前カナ(全角)は、必須であること。' do
        @user.first_name_kana = '亜'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カタカナで入力してください')
      end
      it '生年月日が必須であること。' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end
