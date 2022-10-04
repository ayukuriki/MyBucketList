require 'rails_helper'

RSpec.feature 'lists', type: :system do
  let!(:category1) { create(:category, id: 1) }
  let!(:list1) { create(:list, user_id: current_user.id, title: "リスト1", description: "リスト1説明") }
  let!(:list2) { create(:list, user_id: not_current_user.id, title: "リスト2") }
  let!(:list3) { create(:list, user_id: not_current_user.id, title: "リスト3", public: false) }
  let(:current_user) { create(:user, name: "ログインユーザー", email: "login@gmail.com") }
  let(:not_current_user) { create(:user, name: "非ログインユーザー", email: "unlogin@gmail.com") }

  background do
    driven_by(:rack_test)
    sign_in current_user
  end

  feature '自分のリストが表示される' do
    background do
      visit mypage_path
    end

    scenario 'リストのtitleが表示される' do
      expect(page).to have_content 'リスト1'
    end

    scenario 'リストの内容が表示される' do
      expect(page).to have_content 'リスト1説明'
    end

    scenario '他のユーザーの内容が表示されない' do
      expect(page).not_to have_content 'リスト2'
      expect(page).not_to have_content 'リスト3'
    end
  end

  feature 'リストの作成' do
    background do
      visit mypage_path
    end

    scenario '新規作成画面に遷移する' do
      click_on '新規', match: :first
      expect(page).to have_content '新規リスト作成'
    end

    scenario 'リストの作成ができる' do
      visit  new_list_path

      fill_in 'list[title]', with: '新規作成タイトル'
      fill_in 'list[description]', with: '新規作成メモ'
      select '国内旅行', from: 'list[category_id]'
      fill_in 'list[target_year]', with: '50'
      select '公開', from: 'list[public]'

      click_on '作成'
      expect(page).to have_content '新規作成タイトル'
      expect(page).to have_content '新規作成メモ'
    end
  end

  feature 'リストの編集' do
    background do
      visit mypage_path
    end

    scenario '編集画面に遷移する' do
      find(".edit-link").click
      expect(page).to have_content 'リストを編集'
    end

    scenario 'リストの編集ができる' do
      visit  edit_list_path(list1.id)

      fill_in 'list[title]', with: '編集後リスト1タイトル'
      select '公開', from: 'list[public]'

      click_on '編集'
      expect(page).to have_content '編集後リスト1タイトル'
    end
  end

  feature 'リストの削除' do
    background do
      visit mypage_path
    end

    scenario '削除ボタンを押すとリストが消える' do
      find(".delete-link").click
      expect(page).not_to have_content 'リスト1タイトル'
    end
  end

  feature 'みんなのリストが表示される' do
    background do
      visit sharepage_path
    end

    scenario 'リストのtitleが表示される' do
      expect(page).to have_content 'リスト1'
      expect(page).to have_content 'リスト2'
    end

    scenario '非公開のリストは表示されない' do
      expect(page).not_to have_content 'リスト3'
    end
  end
end
