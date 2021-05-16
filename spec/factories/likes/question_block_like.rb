FactoryBot.define do
  factory :question_block_like do
    association :user
    association :question_block
  end
end