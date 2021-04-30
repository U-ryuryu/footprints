require 'rails_helper'

RSpec.describe Call, type: :model do
  describe '#create' do
    before do
      @call = FactoryBot.build(:call)
    end
    context '新規登録ができる場合' do
      it 'title,date,content,status_idが記載されているなら登録できること' do
        expect(@call).to be_valid
      end
    end
    context '新規登録ができない場合' do
      it 'titleが空では登録できないこと' do
        @call.title = ''
        @call.valid?
        expect(@call.errors.full_messages).to include("タイトルを入力してください")
      end
      it 'dateが空では登録できないこと' do
        @call.date= ''
        @call.valid?
        expect(@call.errors.full_messages).to include("日付を入力してください")
      end
      it 'contentが空では登録できないこと' do
        @call.content= ''
        @call.valid?
        expect(@call.errors.full_messages).to include("問合せ内容を入力してください")
      end
      it 'status_idが1では登録できないこと' do
        @call.status_id = 1
        @call.valid?
        expect(@call.errors.full_messages).to include('ステータスを選択してください')
      end
    end
  end
end
