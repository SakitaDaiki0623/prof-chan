FactoryBot.define do
  factory :text_block do
    title { Faker::Lorem.sentence(word_count: 5) }
    text  { Faker::Lorem.sentence(word_count: 5) }
    association :profile_block
  end
end
