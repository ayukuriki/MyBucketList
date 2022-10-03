require 'rails_helper'

RSpec.feature "users", type: :system do
  let(:category1) { create(:category) }
  let!(:list1) { create(:list, user_id: current_user.id) }
  let!(:list2) { create(:list, user_id: current_user.id) }
  let!(:list3) { create(:list, user_id: not_current_user.id) }
  let!(:achieved_list1) { create(:achieved_list, user_id: current_user.id) }
  let!(:achieved_list2) { create(:achieved_list, user_id: not_current_user.id) }
  let(:current_user) { create(:user, name: "ログインユーザー", email: "login@gmail.com") }
  let(:not_current_user) { create(:user, name: "非ログインユーザー", email: "unlogin@gmail.com") }

  background do
    driven_by(:rack_test)
    sign_in current_user
    visit users_show_path
  end

  feature 'ログインユーザーのプロフィールが表示される' do

    scenario 'ユーザー名が取得できるか' do
      expect(page).to have_content "ログインユーザー"
    end

    scenario 'ユーザーのemailが取得できるか' do
      expect(page).to have_content "login@gmail.com"
    end

    scenario 'リスト数が取得できるか' do
      expect(page).to have_content "BUCKET LISTの数・・・・2"
    end

    scenario '達成リスト数が取得できるか' do
      expect(page).to have_content "達成リストの数・・・・1"
    end

    scenario '編集画面に遷移する' do
      click_on 'プロフィール写真変更'
      expect(page).to have_content 'プロフィール写真変更'
    end

    scenario '編集画面からプロフィール画面に遷移する' do
      visit edit_user_registration_path
      click_on 'プロフィールに戻る'
      expect(page).to have_content "ログインユーザー"
      expect(page).to have_content "login@gmail.com"
    end
  end
end
