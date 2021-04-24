require 'rails_helper'

RSpec.describe QuestionBlock, type: :model do
  it '有効なファクトリを持つこと' do
    expect(create(:question_block)).to be_valid
  end
end

# フォームオブジェクトでテスト
# spec/models/question_block_item_register_spec.rb