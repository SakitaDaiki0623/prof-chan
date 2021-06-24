require 'rails_helper'

RSpec.describe YesOrNoItem, type: :model do
  it '有効なファクトリを持つこと' do
    expect(create(:yes_or_no_item)).to be_valid
  end
end
