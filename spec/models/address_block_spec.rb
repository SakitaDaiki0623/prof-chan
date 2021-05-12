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

require 'rails_helper'

RSpec.describe AddressBlock, type: :model do
  it '有効なファクトリを持つこと' do
    expect(build(:address_block)).to be_valid
  end
end
