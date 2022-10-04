FactoryBot.define do
  factory :question do
    title { 'テストクエスチョン' }
    category_id { '1' }
    content { 'テストの質問をしています' }
    user
  end
end
