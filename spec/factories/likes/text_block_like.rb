FactoryBot.define do
  factory :text_block_like do
    association :user
    association :text_block
  end
end