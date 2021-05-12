# == Schema Information
#
# Table name: yes_or_no_items
#
#  id                 :bigint           not null, primary key
#  content            :string(255)      not null
#  answer             :boolean          not null
#  question_block_id  :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/factories/yes_or_no_item.rb
FactoryBot.define do
  factory :yes_or_no_item do
    content { Faker::Lorem.sentence }
    answer  { [true, false].sample }
    association :yes_or_no_block
  end
end
