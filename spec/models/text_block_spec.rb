# == Schema Information
#
# Table name: profile_blocks
#
#  id                 :bigint           not null, primary key
#  text_block_id            :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/models/text_block.rb
require 'rails_helper'

RSpec.describe TextBlock, type: :model do

  it '有効なファクトリを持つこと' do
    expect(create(:text_block)).to be_valid
  end

  describe 'validations' do
    it 'タイトルがなかったら、テキストブロックの登録に失敗すること' do
      text_block = build(:text_block, title: nil)
      text_block.valid?
      expect(text_block.errors[:title]).to include("を入力してください")
    end

    it 'テキストがなかったら、テキストブロックの登録に失敗すること' do
      text_block = build(:text_block, text: nil)
      text_block.valid?
      expect(text_block.errors[:text]).to include("を入力してください")
    end
  end
end
