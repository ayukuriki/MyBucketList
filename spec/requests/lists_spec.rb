require 'rails_helper'

RSpec.describe "Lists", type: :request do
  let!(:category1) { create(:category, id: 1) }
  let!(:list1) { create(:list, user_id: current_user.id, title: "リスト1", description: "リスト1説明") }
  let!(:list2) { create(:list, user_id: not_current_user.id) }
  let!(:list3) { create(:list, user_id: not_current_user.id, title: "リスト3", public: false) }
  let(:current_user) { create(:user, name: "ログインユーザー", email: "login@gmail.com") }
  let(:not_current_user) { create(:user, name: "非ログインユーザー", email: "unlogin@gmail.com") }

  describe "mypageのテスト" do
    before do
      sign_in current_user
      get mypage_path
    end

    it "正常にレスポンスがされているか" do
      expect(response).to have_http_status(:success)
    end

    it "ログインユーザーのリストが表示されているか" do
      expect(response.body).to include list1.title
      expect(response.body).to include list1.description
    end

    it "ログインユーザー以外のリストが表示されていないか" do
      expect(response.body).not_to include list2.title
      expect(response.body).not_to include list2.description
    end

    it '新規ボタンが表示されている' do
      expect(response.body).to include '新規'
    end
  end

  describe "sharepageのテスト" do
    before do
      sign_in current_user
      get sharepage_path
    end

    it "正常にレスポンスがされているか" do
      expect(response).to have_http_status(:success)
    end

    it "全てのリストが表示されているか" do
      expect(response.body).to include list1.title
      expect(response.body).to include list2.title
      expect(response.body).to include list1.description
      expect(response.body).to include list2.description
    end

    it "非公開のリストが表示されていないか" do
      expect(response.body).not_to include list3.title
    end

    it '新規ボタンが表示されている' do
      expect(response.body).to include '新規'
    end
  end
end
