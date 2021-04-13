# == Schema Information
#
# Table name: profile_blocks
#
#  id                 :bigint           not null, primary key
#  user_id            :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/factories/profile_block.rb
FactoryBot.define do
  factory :text_block do
    title { Faker::Lorem.sentence }
    text  { Faker::Lorem.sentence }
    association :profile_block
  end
end
