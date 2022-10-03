require 'rails_helper'

RSpec.describe "questions", type: :request do
  let!(:question1) { create(:question, title: "質問タイトルです", user_id: current_user.id) }
  let!(:question2) { create(:question, title: "質問2タイトル", user_id: user1.id) }
  let!(:category1) { create(:category, id: 1) }
  let!(:advice) { create(:advice, question_id: question1.id, user_id: user2.id) }
  let(:current_user) { create(:user, name: "ログインユーザー", email: "login@gmail.com") }
  let(:user1) { create(:user, name: "ユーザー1", email: "user1@gmail.com") }
  let(:user2) { create(:user, name: "ユーザー2", email: "user2@gmail.com") }

  describe "質問一覧ページの表示" do
    before do
      sign_in current_user
      get questions_path
    end

    it "正常にレスポンスがされているか" do
      expect(response).to have_http_status(:success)
    end

    it '質問の一覧が表示される' do
      expect(response.body).to include question1.title
      expect(response.body).to include question2.title
    end
  end

  describe "質問詳細ページの表示" do
    before do
      get question_path(question1.id)
    end

    it "正常にレスポンスがされているか" do
      expect(response).to have_http_status(:success)
    end

    it '質問の詳細が表示される' do
      expect(response.body).to include question1.title
      expect(response.body).to include question1.content
    end

    it 'アドバイスが表示される' do
      expect(response.body).to include advice.content
    end
  end
end
