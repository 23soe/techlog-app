FactoryBot.define do
  factory :post do
    title { 'テストタイトル' }
    content { 'テスト内容' }

    association :user, factory: :user
    association :category 
  end
end
