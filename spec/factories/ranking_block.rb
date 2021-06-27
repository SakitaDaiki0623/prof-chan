FactoryBot.define do
  factory :ranking_block do
    title { Faker::Lorem.sentence(word_count: 2) }
    first_place  { Faker::Lorem.sentence(word_count: 2) }
    second_place { Faker::Lorem.sentence(word_count: 2) }
    third_place  { Faker::Lorem.sentence(word_count: 2) }
    association :profile_block
  end
end
