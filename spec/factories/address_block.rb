# == Schema Information
#
# Table name: address_blocks
#
#  id                 :bigint           not null, primary key
#  profile_block_id   :string(255)      not null
#  full_address       :string(255)
#  postcode           :string(255)
#  twitter            :string(255)
#  instagram          :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/factories/address_block.rb
FactoryBot.define do
  factory :address_block do
    full_address { 'a' * 10 }
    postcode     { 'a' * 10 }
    twitter      { 'a' * 10 }
    instagram    { 'a' * 10 }
    association :profile_block
  end
end
