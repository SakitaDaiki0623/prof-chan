# == Schema Information
#
# Table name: question_blocks
#
#  id                 :bigint           not null, primary key
#  title              :string(255)      not null  profile_block_id   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/factories/question_blocks.rb
FactoryBot.define do
  factory :question_block do
    title { Faker::Lorem.sentence(word_count: 5) }
    association :profile_block
    after(:create) do |question_block|
      create_list(:question_item, [1, 2, 3].sample, question_block: question_block)
    end
  end
end
