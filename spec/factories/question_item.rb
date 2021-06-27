FactoryBot.define do
  factory :question_item do
    content { Faker::Lorem.sentence(word_count: 2) }
    answer  { Faker::Lorem.sentence(word_count: 2) }
    association :question_block
  end
end
