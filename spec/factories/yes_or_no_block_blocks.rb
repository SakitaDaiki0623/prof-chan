# == Schema Information
#
# Table name: yes_or_no_blocks
#
#  id                 :bigint           not null, primary key
#  title              :string(255)      not null
#  profile_block_id   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/factories/yes_or_no_block_blocks.rb
FactoryBot.define do
  factory :yes_or_no_block do
    title { 'あ' * 30 }
    association :profile_block
  end
end
