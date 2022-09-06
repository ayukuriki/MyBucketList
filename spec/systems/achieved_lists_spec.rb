require 'rails_helper'

RSpec.feature 'achieved_list', type: :system do
  given(:achieved_list1) { create(:achieved_list, user: [user]) }
  given(:achieved_list2) { create(:achieved_list, public: false, user: [user]) }
  given(:user) { create(:user) }

  feature 'みんなの達成レポが表示される' do
    background do
      visit achieved_lists_path
    end

    scenario '達成レポのtitleが表示される' do
      expect(page).to have_selector 'h4', text: achieved_list1.title
    end

    scenario '達成レポの内容が表示される' do
      expect(page).to have_selector 'p', text: achieved_list1.report
    end

    scenario '達成者が表示される' do
      expect(page).to have_selector 'p', text: user.name
    end

    scenario '公開設定が非公開のものは表示されない' do
      expect(page).to have_selector 'h4', text: achieved_list2.title
      expect(page).to have_selector 'p', text: achieved_list2.report
    end

    scenario 'おめでとうボタンが表示されている' do
      within(".congrats-container") do
        expect(page).to have_selector 'span', text: "おめでとう"
      end
    end

    scenario 'おめでとうボタンを押すとおめでとうの件数が1増える' do
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

  feature '自分の達成レポが表示される' do
    background do
      given(:login_user) { create(:user, name: "login_user") }
      given(:achieved_list3) { create(:achieved_list, user: [login_user]) }
      visit my_achieved_lists_path
    end

    scenario '自分の達成レポのtitleが表示される' do
      expect(page).to have_selector 'h4', text: achieved_list3.title
    end

    scenario '自分の達成レポの内容が表示される' do
      expect(page).to have_selector 'p', text: achieved_list3.report
    end

    scenario '自分のレポ以外は表示されない' do
      expect(page).to have_selector 'p', text: achieved_list1.title
    end
  end
end
