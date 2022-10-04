require 'rails_helper'

RSpec.describe "Top", type: :request do
  before do
    get root_path
  end

  it "正常にレスポンスがされているか" do
    expect(response).to have_http_status(:success)
  end

  it 'メインタイトルが取得できるか' do
    expect(response.body).to include 'MY BUCKET LIST'
  end

  it '機能紹介セクションが表示されているか' do
    expect(response.body).to include 'MY BUCKET LISTでできること'
  end
end
