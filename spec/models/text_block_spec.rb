require 'rails_helper'

RSpec.describe TextBlock, type: :model do
  let(:over_fifteen_words) { 'あ' * 16 }
  let(:over_four_hundreds_words)  { 'あ' * 401 }
  it '有効なファクトリを持つこと' do
    expect(create(:text_block)).to be_valid
  end

  describe 'validations' do
    it 'タイトルがなかったら、テキストブロックの登録に失敗すること' do
      text_block = build(:text_block, title: nil)
      text_block.valid?
      expect(text_block.errors[:title]).to include("を入力してください")
    end

    it 'タイトルが15文字以上なら、テキストブロックの登録に失敗すること' do
      text_block = build(:text_block, title: over_fifteen_words)
      text_block.valid?
      expect(text_block.errors[:title]).to include("は15文字以内で入力してください")
    end

    it 'テキストがなかったら、テキストブロックの登録に失敗すること' do
      text_block = build(:text_block, text: nil)
      text_block.valid?
      expect(text_block.errors[:text]).to include("を入力してください")
    end

    it 'テキストが400文字以上なら、テキストブロックの登録に失敗すること' do
      text_block = build(:text_block, text: over_four_hundreds_words)
      text_block.valid?
      expect(text_block.errors[:text]).to include("は400文字以内で入力してください")
    end
  end
end
