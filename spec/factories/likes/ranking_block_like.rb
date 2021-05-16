FactoryBot.define do
  factory :ranking_block_like do
    association :user
    association :ranking_block
  end
end