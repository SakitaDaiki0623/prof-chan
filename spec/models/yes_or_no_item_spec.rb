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

require 'rails_helper'

RSpec.describe YesOrNoItem, type: :model do
  it '有効なファクトリを持つこと' do
    expect(create(:yes_or_no_item)).to be_valid
  end
end
