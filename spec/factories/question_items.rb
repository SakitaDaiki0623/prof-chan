FactoryBot.define do
  factory :question_item do
    content { Faker::Lorem.sentence }
    answer  { Faker::Lorem.sentence }
    association :question_block
  end
end
