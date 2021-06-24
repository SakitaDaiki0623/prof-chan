require 'rails_helper'

RSpec.describe AddressBlock, type: :model do
  it '有効なファクトリを持つこと' do
    expect(build(:address_block)).to be_valid
  end
end
