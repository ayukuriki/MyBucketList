require 'rails_helper'
RSpec.describe List, type: :model do
  before do
    @list = FactoryBot.build(:list)
  end

  describe 'リスト新規登録' do
    context '新規登録がうまくいくとき' do
      it "内容に問題ない場合" do
        expect(@list).to be_valid
      end
    end
 
    context 'リストの新規登録がうまくいかないとき' do
      it "titleが空だと登録できない" do
        @list.title = ""
        @list.valid?
        expect(@list.errors.full_messages).to include("リスト名を入力してください")
      end
      it "publicが空では登録できない" do
        @list.public = ""
        @list.valid?
        expect(@list.errors.full_messages).to include("公開設定は一覧にありません")
      end
      it "カテゴリーが空では登録できない" do
        @list.category_id = ""
        @list.valid?
        expect(@list.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it "titleが17文字以上であれば登録できない" do
        @list.title = "aaaaaaaaaaaaaaaaaaaaaa"
        @list.valid?
        expect(@list.errors.full_messages).to include("リスト名は16文字以内で入力してください")
      end
      it "descriptionが31文字以上であれば登録できない" do
        @list.description = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        @list.valid?
        expect(@list.errors.full_messages).to include("メモは30文字以内で入力してください")
      end
    end
  end 
end
