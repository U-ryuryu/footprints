require 'rails_helper'

RSpec.describe Visit, type: :model do
  describe '#create' do
    before do
      @visit = FactoryBot.build(:visit)
    end
    context '新規登録ができる場合' do
      it 'title,date,content,status_idが記載されているなら登録できること' do
        expect(@visit).to be_valid
      end
    end
    context '新規登録ができない場合' do
      it 'titleが空では登録できないこと' do
        @visit.title = ''
        @visit.valid?
        expect(@visit.errors.full_messages).to include("タイトルを入力してください")
      end
      it 'dateが空では登録できないこと' do
        @visit.date= ''
        @visit.valid?
        expect(@visit.errors.full_messages).to include("訪問日を入力してください")
      end
      it 'contentが空では登録できないこと' do
        @visit.content= ''
        @visit.valid?
        expect(@visit.errors.full_messages).to include("作業内容を入力してください")
      end
      it 'status_idが1では登録できないこと' do
        @visit.status_id = 1
        @visit.valid?
        expect(@visit.errors.full_messages).to include('ステータスを選択してください')
      end
    end
  end
end
