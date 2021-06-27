# spec/models/question_block_item_register_spec.rb

# [対象フォーム] app/forms/question_block_item_register.rb

require 'rails_helper'

RSpec.describe QuestionBlockItemRegister, type: :model do
  let(:question_block_item_register) { QuestionBlockItemRegister.new }
  let(:over_fifteen_words) { 'あ' * 16 }
  let(:over_twenty_words)  { 'あ' * 21 }

  describe 'バリデーション' do

    it 'クエスチョンブロックのタイトルがなかったら、エラーメッセージを返すこと' do
      question_block_item_register.question_title = ""
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_title]).to include("を入力してください")
    end

    it 'クエスチョンブロックのタイトルが15文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_title = over_fifteen_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_title]).to include("は15文字以内で入力してください")
    end

    it 'クエスチョンブロックの質問内容1がなかったら、エラーメッセージを返すこと' do
      question_block_item_register.question_item_content1 = ""
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_content1]).to include("を入力してください")
    end

    it 'クエスチョンブロックの質問内容1が20文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_item_content1 = over_twenty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_content1]).to include("は20文字以内で入力してください")
    end

    it 'クエスチョンブロックの答え1が20文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_item_answer1 = over_twenty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_answer1]).to include("は20文字以内で入力してください")
    end

    it 'クエスチョンブロックの質問内容2が20文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_item_content2 = over_twenty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_content2]).to include("は20文字以内で入力してください")
    end

    it 'クエスチョンブロックの答え2が20文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_item_answer2 = over_twenty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_answer2]).to include("は20文字以内で入力してください")
    end

    it 'クエスチョンブロックの質問内容3が20文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_item_content3 = over_twenty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_content3]).to include("は20文字以内で入力してください")
    end

    it 'クエスチョンブロックの答え3が20文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_item_answer3 = over_twenty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_answer3]).to include("は20文字以内で入力してください")
    end
  end
end
