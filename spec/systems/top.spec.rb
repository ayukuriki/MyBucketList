require 'rails_helper'

RSpec.feature "Top", type: :system do
  feature 'みんなの達成レポが表示される' do
    background do
      driven_by(:rack_test)
      visit root_path
    end

    scenario 'メインタイトルが取得できるか' do
      expect(page).to have_content('MY BUCKET LIST')
    end

    scenario '機能紹介セクションが表示されているか' do
      expect(page).to have_content('MY BUCKET LISTでできること')
    end
  end
end
