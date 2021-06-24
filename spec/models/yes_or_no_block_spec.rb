require 'rails_helper'

RSpec.describe YesOrNoBlock, type: :model do
  it '有効なファクトリを持つこと' do
    expect(create(:yes_or_no_block)).to be_valid
  end
end
