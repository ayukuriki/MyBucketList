require 'rails_helper'

RSpec.describe "User", type: :request do
  let(:category1) { create(:category) }
  let!(:list1) { create(:list, user_id: current_user.id) }
  let!(:list2) { create(:list, user_id: current_user.id) }
  let!(:list3) { create(:list, user_id: not_current_user.id) }
  let!(:achieved_list1) { create(:achieved_list, user_id: current_user.id) }
  let!(:achieved_list2) { create(:achieved_list, user_id: not_current_user.id) }
  let(:current_user) { create(:user, name: "ログインユーザー", email: "login@gmail.com") }
  let(:not_current_user) { create(:user, name: "非ログインユーザー", email: "unlogin@gmail.com") }

  before do
    sign_in current_user
    get users_show_path
  end

  it "正常にレスポンスがされているか" do
    expect(response).to have_http_status(:success)
  end

  it 'ユーザー名が取得できるか' do
    expect(response.body).to include current_user.name
  end

  it 'ユーザーのemailが取得できるか' do
    expect(response.body).to include current_user.email
  end

  it 'リスト数が取得できるか' do
    expect(response.body).to include "BUCKET LISTの数・・・・<span>2</span>"
  end

  it '達成リスト数が取得できるか' do
    expect(response.body).to include "達成リストの数・・・・<span>1</span>"
  end
end
