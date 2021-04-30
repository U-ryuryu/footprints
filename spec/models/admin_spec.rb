require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#create' do
    before do
      @admin = FactoryBot.build(:admin)
    end
    context '新規登録ができる場合' do
      it 'name,email,password,password_confirmationが記載されていれば登録できること' do
        expect(@admin).to be_valid
      end
      it 'passwordが6文字以上で英数字混合であれば登録できること' do
        @admin.password = 'abc123'
        @admin.password_confirmation = @admin.password
        expect(@admin).to be_valid
      end
    end
    context '新規登録ができない場合' do
      it 'nameが空では登録できないこと' do
        @admin.name = ''
        @admin.valid?
        expect(@admin.errors.full_messages).to include("団体名を入力してください")
      end
      it 'emailが空では登録できないこと' do
        @admin.email = ''
        @admin.valid?
        expect(@admin.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空では登録できないこと' do
        @admin.password = ''
        @admin.password_confirmation = ''
        @admin.valid?
        expect(@admin.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下であれば登録できないこと' do
        @admin.password = 'ab123'
        @admin.password_confirmation = @admin.password
        @admin.valid?
        expect(@admin.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが数字のみでは登録できないこと' do
        @admin.password = '123456'
        @admin.password_confirmation = @admin.password
        @admin.valid?
        expect(@admin.errors.full_messages).to include('パスワードは半角英数字の組合せで入力してください')
      end
      it 'passwordが英字のみでは登録できないこと' do
        @admin.password = 'abcdef'
        @admin.password_confirmation = @admin.password
        @admin.valid?
        expect(@admin.errors.full_messages).to include('パスワードは半角英数字の組合せで入力してください')
      end
      it 'passwordに全角が含まれると登録できないこと' do
        @admin.password = 'abｃ123'
        @admin.password_confirmation = @admin.password
        @admin.valid?
        expect(@admin.errors.full_messages).to include('パスワードは半角英数字の組合せで入力してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @admin.password = 'abc123'
        @admin.password_confirmation = '123abc'
        @admin.valid?
        expect(@admin.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'emailは@が含まれていなければ登録でないこと' do
        @admin.email = 'abc123'
        @admin.valid?
        expect(@admin.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'emailは先頭が@では登録でないこと' do
        @admin.email = '@abc@123'
        @admin.valid?
        expect(@admin.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'emailは末尾が@では登録でないこと' do
        @admin.email = 'abc@123@'
        @admin.valid?
        expect(@admin.errors.full_messages).to include('Eメールは不正な値です')
      end
      it '重複したemailが存在する場合登録できないこと' do
        @admin.save
        anather_admin = FactoryBot.build(:admin, email: @admin.email)
        anather_admin.valid?
        expect(anather_admin.errors.full_messages).to include('Eメールはすでに存在します')
      end
    end
  end
end
