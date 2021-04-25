# spec/models/yes_or_no_item_spec.rb
require 'rails_helper'

RSpec.describe YesOrNoBlockItemRegister, type: :model do
  let(:yes_or_no_block_item_register) { YesOrNoBlockItemRegister.new }
  let(:over_fifty_words) { 'あ' * 51 }

  describe 'バリデーション' do

    it 'YES or NO ブロックのタイトルがなかったら、エラーメッセージを返すこと' do
      yes_or_no_block_item_register.yes_or_no_title = ""
      yes_or_no_block_item_register.valid?
      expect(yes_or_no_block_item_register.errors[:yes_or_no_title]).to include("を入力してください")
    end

    it 'YES or NO ブロックのタイトルが50文字より大きい時、エラーメッセージを返すこと' do
      yes_or_no_block_item_register.yes_or_no_title = over_fifty_words
      yes_or_no_block_item_register.valid?
      expect(yes_or_no_block_item_register.errors[:yes_or_no_title]).to include("は50文字以内で入力してください")
    end

    it 'YES or NO ブロックの質問内容1がなかったら、エラーメッセージを返すこと' do
      yes_or_no_block_item_register.yes_or_no_item_content1 = ""
      yes_or_no_block_item_register.valid?
      expect(yes_or_no_block_item_register.errors[:yes_or_no_item_content1]).to include("を入力してください")
    end

    it 'YES or NO ブロックの質問内容1が50文字より大きい時、エラーメッセージを返すこと' do
      yes_or_no_block_item_register.yes_or_no_item_content1 = over_fifty_words
      yes_or_no_block_item_register.valid?
      expect(yes_or_no_block_item_register.errors[:yes_or_no_item_content1]).to include("は50文字以内で入力してください")
    end

    it 'YES or NO ブロックの質問内容2が50文字より大きい時、エラーメッセージを返すこと' do
      yes_or_no_block_item_register.yes_or_no_item_content2 = over_fifty_words
      yes_or_no_block_item_register.valid?
      expect(yes_or_no_block_item_register.errors[:yes_or_no_item_content2]).to include("は50文字以内で入力してください")
    end

    it 'YES or NO ブロックの質問内容3が50文字より大きい時、エラーメッセージを返すこと' do
      yes_or_no_block_item_register.yes_or_no_item_content3 = over_fifty_words
      yes_or_no_block_item_register.valid?
      expect(yes_or_no_block_item_register.errors[:yes_or_no_item_content3]).to include("は50文字以内で入力してください")
    end
  end
end
