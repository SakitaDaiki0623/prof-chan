# == Schema Information
#
# Table name: address_blocks
#
#  id                 :bigint           not null, primary key
#  profile_block_id   :string(255)      not null
#  full_address       :string(255)      not null
#  postcode           :string(255)      not null
#  twitter            :string(255)      not null
#  instagram          :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# app/models/address_block.rb

class AddressBlock < ApplicationRecord
  # association ==========
  belongs_to :profile_block
end
