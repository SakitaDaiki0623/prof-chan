require 'rails_helper'

RSpec.describe QuestionBlockItemRegister, type: :model, focus: true do
  let(:question_block_item_register) { QuestionBlockItemRegister.new }
  let(:title_over_thirty_words) { 'あ' * 31 }

  describe 'バリデーション' do

    it 'クエスチョンブロックのタイトルがなかったら、ユーザー登録に失敗すること' do
      question_block_item_register.question_title = ""
      profile.valid?
      expect(profile.errors[:height]).to include("を入力してください")
    end

    it 'クエスチョンブロックのタイトルが30文字より大きい時、エラーメッセージを返すこと' do
      question_block_item_register.question_title = title_over_thirty_words
      question_block_item_register.valid?
      expect(profile.errors[:question_title]).to include("は30文字以内で入力してください")
    end
  end
end
