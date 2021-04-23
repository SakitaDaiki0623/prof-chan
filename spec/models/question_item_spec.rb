require 'rails_helper'

RSpec.describe QuestionItem, type: :model do
  it '有効なファクトリを持つこと' do
    expect(create(:question_item)).to be_valid
  end
end
