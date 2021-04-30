require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end
    context '新規登録ができる場合' do
      it 'name,email,password,password_confirmationが記載されていれば登録できること' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上で英数字混合であれば登録できること' do
        @user.password = 'abc123'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end
    context '新規登録ができない場合' do
      it 'nameが空では登録できないこと' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ユーザー名を入力してください")
      end
      it 'emailが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空では登録できないこと' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下であれば登録できないこと' do
        @user.password = 'ab123'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字の組合せで入力してください')
      end
      it 'passwordが英字のみでは登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字の組合せで入力してください')
      end
      it 'passwordに全角が含まれると登録できないこと' do
        @user.password = 'abｃ123'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字の組合せで入力してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = 'abc123'
        @user.password_confirmation = '123abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'emailは@が含まれていなければ登録でないこと' do
        @user.email = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'emailは先頭が@では登録でないこと' do
        @user.email = '@abc@123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'emailは末尾が@では登録でないこと' do
        @user.email = 'abc@123@'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        anather_user = FactoryBot.build(:user, email: @user.email)
        anather_user.valid?
        expect(anather_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
    end
  end
end
