# spec/models/question_block_item_register_spec.rb

# [対象フォーム] app/forms/question_block_item_register.rb

require 'rails_helper'

RSpec.describe QuestionBlockItemRegister, type: :model do
  let(:question_block_item_register) { QuestionBlockItemRegister.new }
  let(:over_fifty_words) { 'あ' * 51 }

  describe 'バリデーション' do

    it 'クエスチョンブロックのタイトルがなかったら、ユーザー登録に失敗すること' do
      question_block_item_register.question_title = ""
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_title]).to include("を入力してください")
    end

    it 'クエスチョンブロックのタイトルが50文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_title = over_fifty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_title]).to include("は50文字以内で入力してください")
    end

    it 'クエスチョンブロックの質問内容1がなかったら、ユーザー登録に失敗すること' do
      question_block_item_register.question_item_content1 = ""
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_content1]).to include("を入力してください")
    end

    it 'クエスチョンブロックの質問内容1が50文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_item_content1 = over_fifty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_content1]).to include("は50文字以内で入力してください")
    end

    it 'クエスチョンブロックの答え1が50文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_item_answer1 = over_fifty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_answer1]).to include("は50文字以内で入力してください")
    end

    it 'クエスチョンブロックの質問内容2が50文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_item_content2 = over_fifty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_content2]).to include("は50文字以内で入力してください")
    end

    it 'クエスチョンブロックの答え2が50文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_item_answer2 = over_fifty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_answer2]).to include("は50文字以内で入力してください")
    end

    it 'クエスチョンブロックの質問内容3が50文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_item_content3 = over_fifty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_content3]).to include("は50文字以内で入力してください")
    end

    it 'クエスチョンブロックの答え3が50文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_item_answer3 = over_fifty_words
      question_block_item_register.valid?
      expect(question_block_item_register.errors[:question_item_answer3]).to include("は50文字以内で入力してください")
    end
  end
end
