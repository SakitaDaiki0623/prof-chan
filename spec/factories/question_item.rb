# == Schema Information
#
# Table name: question_items
#
#  id                 :bigint           not null, primary key
#  content            :string(255)      not null
#  answer             :string(255)
#  question_block_id  :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/factories/question_item.rb
FactoryBot.define do
  factory :question_item do
    content { Faker::Lorem.sentence(word_count: 5) }
    answer  { Faker::Lorem.sentence(word_count: 5) }
    association :question_block
  end
end
