FactoryBot.define do
  factory :advice do
    content {'質問に対するアドバイスです'}
    association :user
    association :question
  end
end
