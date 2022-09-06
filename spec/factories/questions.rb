FactoryBot.define do
  factory :question do
    id { '1' }
    title { 'テストクエスチョン' }
    category_id { '3' }
    content { 'テストの質問をしています' }
    user
  end
end
