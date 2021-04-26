# spec/models/my_favorite_block_spec.rb
require 'rails_helper'

RSpec.describe MyFavoriteBlock, type: :model do
  let(:over_fifteen_words) { 'あ' * 16 }

  it '有効なファクトリを持つこと' do
    expect(build(:my_favorite_block)).to be_valid
  end

  describe 'validations' do
    it 'manga_animeが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, manga_anime: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:manga_anime]).to include("は15文字以内で入力してください")
    end
    it 'game_appが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, game_app: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:game_app]).to include("は15文字以内で入力してください")
    end
    it 'characterが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, character: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:character]).to include("は15文字以内で入力してください")
    end
    it 'actorが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, actor: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:actor]).to include("は15文字以内で入力してください")
    end
    it 'entertainerが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, entertainer: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:entertainer]).to include("は15文字以内で入力してください")
    end
    it 'musicianが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, musician: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:musician]).to include("は15文字以内で入力してください")
    end
    it 'musicが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, music: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:music]).to include("は15文字以内で入力してください")
    end
    it 'foodが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, food: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:food]).to include("は15文字以内で入力してください")
    end
    it 'animalが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, animal: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:animal]).to include("は15文字以内で入力してください")
    end
    it 'sportsが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, sports: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:sports]).to include("は15文字以内で入力してください")
    end
    it 'bookが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, book: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:book]).to include("は15文字以内で入力してください")
    end
    it 'placeが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, place: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:place]).to include("は15文字以内で入力してください")
    end
    it 'snackが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, snack: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:snack]).to include("は15文字以内で入力してください")
    end
    it 'alcohol_drinkが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, alcohol_drink: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:alcohol_drink]).to include("は15文字以内で入力してください")
    end
    it 'restaurantsが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, restaurants: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:restaurants]).to include("は15文字以内で入力してください")
    end
    it 'youtuberが16文字以上なら、My Favorite ブロックの登録に失敗すること' do
      my_favorite_block = build(:my_favorite_block, youtuber: over_fifteen_words)
      my_favorite_block.valid?
      expect(my_favorite_block.errors[:youtuber]).to include("は15文字以内で入力してください")
    end
  end
end
