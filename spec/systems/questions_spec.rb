require 'rails_helper'

RSpec.feature 'questions', type: :system do
  let!(:question1) { create(:question, title: "質問1タイトル", content: "質問1の中身", user_id: user1.id) }
  let!(:question2) { create(:question, title: "質問2タイトル", user_id: user1.id) }
  let!(:category1) { create(:category, id: 1) }
  let!(:advice) { create(:advice, content:"アドバイス1", question_id: question1.id, user_id: user2.id) }
  let(:current_user) { create(:user, name: "ログインユーザー", email: "login@gmail.com") }
  let(:user1) { create(:user, name: "ユーザー1", email: "user1@gmail.com") }
  let(:user2) { create(:user, name: "ユーザー2", email: "user2@gmail.com") }

  background do
    driven_by(:rack_test)
    sign_in current_user
    visit questions_path
  end

  feature "質問一覧ページの表示" do
    scenario '質問の一覧が表示される' do
      expect(page).to have_content '質問1タイトル'
      expect(page).to have_content '質問2タイトル'
    end
  end

  feature "質問詳細ページの表示" do
    background do
      visit question_path(question1.id)
    end

    scenario '質問の詳細が表示される' do
      expect(page).to have_content '質問1タイトル'
      expect(page).to have_content '質問1の中身'
    end

    scenario '質問者の名前が表示される' do
      expect(page).to have_content 'ユーザー1'
    end

    scenario 'アドバイスが表示される' do
      expect(page).to have_content 'アドバイス1'
    end

    scenario 'アドバイス投稿者の名前が表示される' do
      expect(page).to have_content 'ユーザー2'
    end
  end

  feature "質問の新規作成" do

    scenario '新規作成画面に遷移する' do
      click_on '質問する', match: :first
      expect(page).to have_content '新規質問作成'      
    end


    scenario '質問の作成ができる' do
      visit new_question_path

      fill_in 'question[title]', with: '新規質問タイトル'
      fill_in 'question[content]', with: '新規質問メモ'
      select '国内旅行', from: 'question[category_id]'

      click_on '投稿'
      expect(page).to have_content '新規質問タイトル'
    end
  end
end