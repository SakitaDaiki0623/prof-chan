FactoryBot.define do
  factory :ranking_block do
    title { Faker::Lorem.sentence(word_count: 5) }
    first_place  { Faker::Lorem.sentence(word_count: 5) }
    second_place { Faker::Lorem.sentence(word_count: 5) }
    third_place  { Faker::Lorem.sentence(word_count: 5) }
    association :profile_block
  end
end
