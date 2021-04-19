require 'rails_helper'

RSpec.describe QuestionBlock, type: :model do
  it '有効なファクトリを持つこと' do
    expect(create(:question_block)).to be_valid
  end
end
