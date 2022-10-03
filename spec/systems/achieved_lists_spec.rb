require 'rails_helper'

RSpec.feature 'achieved_list', type: :system do
  let!(:achieved_list1) { create(:achieved_list, title: "達成タイトル1", report: "1達成できました", user_id: user1.id) }
  let!(:achieved_list2) { create(:achieved_list, title: "達成タイトル2", report: "2達成できました", user_id: current_user.id) }
  let!(:achieved_list3) { create(:achieved_list, title: "非公開タイトル", public: false) }
  let(:current_user) { create(:user, name: "ログインユーザー", email: "login@gmail.com") }
  let(:user1) { create(:user, name: "ユーザー1", email: "user1@gmail.com") }

  background do
    driven_by(:rack_test)
    sign_in current_user
  end

  feature 'みんなの達成レポが表示される' do

    background do
      visit achieved_lists_path
    end

    scenario '達成レポのtitleが表示される' do
      expect(page).to have_content "達成タイトル1"
      expect(page).to have_content "達成タイトル2"
    end

    scenario '達成レポの内容が表示される' do
      expect(page).to have_content "1達成できました"
      expect(page).to have_content "2達成できました"
    end

    scenario '達成者が表示される' do
      expect(page).to have_content "ログインユーザー"
      expect(page).to have_content "ユーザー1"
    end

    scenario '公開設定が非公開のものは表示されない' do
      expect(page).not_to have_content "非公開タイトル"
    end

    scenario 'おめでとうボタンが表示されている' do
        expect(page).to have_content "おめでとう"
    end

    it 'おめでとうボタンを押すとおめでとうの件数が1増える' do
      within (".congrats-container"), match: :first do
        find('.link').click
        expect(page).to have_content "1"
        find('.link').click
        expect(page).to have_content "0"
      end
    end
  end

  feature '自分の達成レポが表示される' do
    background do
      visit my_achieved_lists_path
    end

    scenario '自分の達成レポのtitleが表示される' do
      expect(page).to have_content "達成タイトル2"
    end

    scenario '自分の達成レポの内容が表示される' do
      expect(page).to have_content "2達成できました"
    end

    scenario '自分のレポ以外は表示されない' do
      expect(page).not_to have_content "達成タイトル1"
      expect(page).not_to have_content "非公開タイトル"
    end
  end
end
