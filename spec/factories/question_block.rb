# == Schema Information
#
# Table name: question_blocks
#
#  id                 :bigint           not null, primary key
#  title              :string(255)      not null
#  profile_block_id   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/factories/question_blocks.rb
FactoryBot.define do
  factory :question_block do
    title { Faker::Lorem.characters(number: 30) }
    association :profile_block
    after(:create) do |question_block|
      [1, 2, 3].sample.times do
        create(:question_item, question_block: question_block)
      end
    end
  end
end
