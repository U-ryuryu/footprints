require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '#create' do
    before do
      @admin = FactoryBot.create(:admin)
      @client = FactoryBot.build(:client)
      @client.admin_id = @admin.id
    end
    context '新規登録ができる場合' do
      it 'name,tel,postal_code,addressが記載されており、charge_telが半角数字11桁以内なら登録できること' do
        expect(@client).to be_valid
      end
      it 'telが11桁以下の数字なら登録できること' do
        @client.tel = '99999999999'
        expect(@client).to be_valid
      end
      it 'chargeが空でも登録できること' do
        @client.charge = nil
        expect(@client).to be_valid
      end
      it 'charge_telが空でも登録できること' do
        @client.charge_tel = nil
        expect(@client).to be_valid
      end
      it 'charge_telが11桁以下の数字なら登録できること' do
        @client.charge_tel = '99999999999'
        expect(@client).to be_valid
      end
    end
    context '新規登録ができない場合' do
      it 'nameが空では登録できないこと' do
        @client.name = ''
        @client.valid?
        expect(@client.errors.full_messages).to include("客先名を入力してください")
      end
      it 'telが空では登録できないこと' do
        @client.tel = ''
        @client.valid?
        expect(@client.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'postal_codeが空では登録できないこと' do
        @client.postal_code = ''
        @client.valid?
        expect(@client.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'addressが空では登録できないこと' do
        @client.address = ''
        @client.valid?
        expect(@client.errors.full_messages).to include("住所を入力してください")
      end
      it 'telが12桁以上では登録できないこと' do
        @client.tel = '111111111111'
        @client.valid?
        expect(@client.errors.full_messages).to include('電話番号は11文字以内で入力してください')
      end
      it 'telに全角数字が含まれていると登録できないこと' do
        @client.tel = '12３45６78９'
        @client.valid?
        expect(@client.errors.full_messages).to include('電話番号半角数字のみで入力してください')
      end
      it 'telに数字以外が含まれていると登録できないこと' do
        @client.tel = '12as4455'
        @client.valid?
        expect(@client.errors.full_messages).to include('電話番号半角数字のみで入力してください')
      end
      it 'postal_codeにハイフンがなくては登録できないこと' do
        @client.postal_code = '1234444'
        @client.valid?
        expect(@client.errors.full_messages).to include('郵便番号はハイフン(-)を含む半角数字7桁で入力してください')
      end
      it 'postal_codeが3文字-4文字でなくては登録できないこと' do
        @client.postal_code = '1234-444'
        @client.valid?
        expect(@client.errors.full_messages).to include('郵便番号はハイフン(-)を含む半角数字7桁で入力してください')
      end
      it 'charge_telが12桁以上では登録できないこと' do
        @client.charge_tel = '111111111111'
        @client.valid?
        expect(@client.errors.full_messages).to include('担当者電話番号は11文字以内で入力してください')
      end
      it 'charge_telに全角数字が含まれていると登録できないこと' do
        @client.charge_tel = '12３45６78９'
        @client.valid?
        expect(@client.errors.full_messages).to include('担当者電話番号半角数字のみで入力してください')
      end
      it 'charge_telに数字以外が含まれていると登録できないこと' do
        @client.charge_tel = '12as4455'
        @client.valid?
        expect(@client.errors.full_messages).to include('担当者電話番号半角数字のみで入力してください')
      end
    end
  end
end
