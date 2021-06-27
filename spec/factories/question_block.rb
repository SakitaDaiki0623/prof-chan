FactoryBot.define do
  factory :question_block do
    title { Faker::Lorem.sentence(word_count: 2) }
    association :profile_block
    after(:create) do |question_block|
      create_list(:question_item, [1, 2, 3].sample, question_block: question_block)
    end
  end
end
