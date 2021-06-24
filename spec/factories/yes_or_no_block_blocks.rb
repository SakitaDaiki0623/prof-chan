FactoryBot.define do
  factory :yes_or_no_block do
    title { Faker::Lorem.sentence(word_count: 5) }
    association :profile_block
    after(:create) do |yes_or_no_block|
      create_list(:yes_or_no_item, [1, 2, 3].sample, yes_or_no_block: yes_or_no_block)
    end
  end
end
