require 'rails_helper'

RSpec.describe RankingBlock, type: :model do
  it '有効なファクトリを持つこと' do
    expect(create(:ranking_block)).to be_valid
  end

  describe 'validations' do
    it 'タイトルがなかったら、ランキングブロックの登録に失敗すること' do
      ranking_block = build(:ranking_block, title: nil)
      ranking_block.valid?
      expect(ranking_block.errors[:title]).to include("を入力してください")
    end

    it 'タイトルが51文字以上なら、ランキングブロックの登録に失敗すること' do
      ranking_block = build(:ranking_block, title: 'a' * 51)
      ranking_block.valid?
      expect(ranking_block.errors[:title]).to include("は50文字以内で入力してください")
    end

    it '第1位がなかったら、ランキングブロックの登録に失敗すること' do
      ranking_block = build(:ranking_block, first_place: nil)
      ranking_block.valid?
      expect(ranking_block.errors[:first_place]).to include("を入力してください")
    end

    it '第1位が51文字以上なら、ランキングブロックの登録に失敗すること' do
      ranking_block = build(:ranking_block, first_place: 'a' * 51)
      ranking_block.valid?
      expect(ranking_block.errors[:first_place]).to include("は50文字以内で入力してください")
    end

    it '第2位がなかったら、ランキングブロックの登録に失敗すること' do
      ranking_block = build(:ranking_block, second_place: nil)
      ranking_block.valid?
      expect(ranking_block.errors[:second_place]).to include("を入力してください")
    end

    it '第2位が51文字以上なら、ランキングブロックの登録に失敗すること' do
      ranking_block = build(:ranking_block, second_place: 'a' * 51)
      ranking_block.valid?
      expect(ranking_block.errors[:second_place]).to include("は50文字以内で入力してください")
    end

    it '第3位がなかったら、ランキングブロックの登録に失敗すること' do
      ranking_block = build(:ranking_block, third_place: nil)
      ranking_block.valid?
      expect(ranking_block.errors[:third_place]).to include("を入力してください")
    end

    it '第3位が51文字以上なら、ランキングブロックの登録に失敗すること' do
      ranking_block = build(:ranking_block, third_place: 'a' * 51)
      ranking_block.valid?
      expect(ranking_block.errors[:third_place]).to include("は50文字以内で入力してください")
    end
  end
end
