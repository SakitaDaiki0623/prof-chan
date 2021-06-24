FactoryBot.define do
  factory :yes_or_no_item do
    content { Faker::Lorem.sentence(word_count: 5) }
    answer  { [true, false].sample }
    association :yes_or_no_block
  end
end
