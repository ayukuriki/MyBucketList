require 'rails_helper'
RSpec.describe AchievedList, type: :model do
  before do
    @achieved_list = FactoryBot.create(:achieved_list)
  end

  describe 'リスト新規登録' do
    context '新規登録がうまくいくとき' do
      it "内容に問題ない場合" do
        expect(@achieved_list).to be_valid
      end
    end

    context 'リストの新規登録がうまくいかないとき' do
      it "reportが空では登録できない" do
        @achieved_list.report = ""
        @achieved_list.valid?
        expect(@achieved_list.errors.full_messages).to include("達成レポを入力してください")
      end
      it "publicが空では登録できない" do
        @achieved_list.public = ""
        @achieved_list.valid?
        expect(@achieved_list.errors.full_messages).to include("公開設定は一覧にありません")
      end
      it "achieved_dateが空では登録できない" do
        @achieved_list.achieved_date = ""
        @achieved_list.valid?
        expect(@achieved_list.errors.full_messages).to include("達成日を入力してください")
      end
    end
  end
end
