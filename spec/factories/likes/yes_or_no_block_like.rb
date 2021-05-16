FactoryBot.define do
  factory :yes_or_no_block_like do
    association :user
    association :yes_or_no_block
  end
end