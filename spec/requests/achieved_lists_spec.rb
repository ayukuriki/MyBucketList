require 'rails_helper'

RSpec.describe "achieved_list", type: :request do
  let!(:achieved_list1) { create(:achieved_list, title: "達成タイトル", report: "達成できました", public: true, user_id: current_user.id) }
  let!(:achieved_list2) { create(:achieved_list, title: "非公開", public: false) }
  let(:category1) { create(:category) }
  let(:current_user) { create(:user, name: "ログインユーザー", email: "login@gmail.com") }
  let(:user1) { create(:user, name: "ユーザー1", email: "user1@gmail.com") }

  before do
    sign_in current_user
    get achieved_lists_path
  end

  it "正常にレスポンスがされているか" do
    expect(response).to have_http_status(:success)
  end

  it '達成レポのtitleが表示される' do
    expect(response.body).to include achieved_list1.title
  end

  it '達成レポの内容が表示される' do
    expect(response.body).to include achieved_list1.report
  end

  it '公開設定が非公開のものは表示されない' do
    expect(response.body).not_to include achieved_list2.title
    expect(response.body).not_to include achieved_list2.report
  end

  it 'おめでとうボタンが表示されている' do
    within(".congrats-container") do
      expect(response.body).to include 'おめでとう'
    end
  end
  
  it 'おめでとうボタンを押すとおめでとうの件数が1増える' do
    within(".congrats-container") do
      find('.link').click
      expect(page).to have_selector 'span', text: "1"
      expect(achieved_list1.congrats.count).to eq(1)
      find('.link').click
      expect(page).to have_selector 'span', text: "0"
      expect(achieved_list1.congrats.count).to eq(0)
    end
  end
end
