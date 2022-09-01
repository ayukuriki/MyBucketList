FactoryBot.define do
  factory :list do
    title { 'テスト作成' }
    description { 'テストデータの作成をする' }
    target_year { '10' }
    public { true }
    category_id { '1' }
    user
  end
end
