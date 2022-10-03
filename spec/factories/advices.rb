FactoryBot.define do
  factory :advice do
    content { '質問に対するアドバイスです' }
    user
    question
  end
end
