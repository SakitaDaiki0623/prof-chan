FactoryBot.define do
  factory :profile_block do
    association :user

    after(:create) do |profile_block|
      create_list(:question_block, 3, profile_block: profile_block)
      create_list(:ranking_block, 3, profile_block: profile_block)
      create_list(:text_block, 3, profile_block: profile_block)
      create_list(:yes_or_no_block, 3, profile_block: profile_block)
    end
  end
end
