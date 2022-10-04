FactoryBot.define do
  factory :achieved_list do
    title { 'テスト作成' }
    report { 'テストデータの作成をする' }
    public { true }
    category_id { '1' }
    achieved_date { '20120809' }
    user
  end
end
