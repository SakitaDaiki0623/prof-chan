# == Schema Information
#
# Table name: text_blocks
#
#  id                 :bigint           not null, primary key
#  title              :string(255)      not null
#  text               :text             not null
#  profile_block_id   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/factories/text_block.rb
FactoryBot.define do
  factory :text_block do
    title { Faker::Lorem.sentence(word_count: 5) }
    text  { Faker::Lorem.sentence(word_count: 5) }
    association :profile_block
  end
end
