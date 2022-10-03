require 'rails_helper'
RSpec.describe Question, type: :model do
  before do
    @question = FactoryBot.create(:question)
  end

  describe 'リスト新規登録' do
    context '新規登録がうまくいくとき' do
      it "内容に問題ない場合" do
        expect(@question).to be_valid
      end
    end

    context 'リストの新規登録がうまくいかないとき' do
      it "titleが空だと登録できない" do
        @question.title = ""
        @question.valid?
        expect(@question.errors.full_messages).to include("質問名を入力してください")
      end
      it "categoryが空では登録できない" do
        @question.category_id = ""
        @question.valid?
        expect(@question.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it "contentが空では登録できない" do
        @question.content = ""
        @question.valid?
        expect(@question.errors.full_messages).to include("質問内容を入力してください")
      end
      it "titleが33文字以上であれば登録できない" do
        @question.title = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        @question.valid?
        expect(@question.errors.full_messages).to include("質問名は32文字以内で入力してください")
      end
    end
  end
end
