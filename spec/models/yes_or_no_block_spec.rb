# == Schema Information
#
# Table name: yes_or_no_blocks
#
#  id                 :bigint           not null, primary key
#  title              :string(255)      not null
#  profile_block_id   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/models/yes_or_no_block_spec.rb
require 'rails_helper'

RSpec.describe YesOrNoBlock, type: :model do
  it '有効なファクトリを持つこと' do
    expect(create(:yes_or_no_block)).to be_valid
  end
end
