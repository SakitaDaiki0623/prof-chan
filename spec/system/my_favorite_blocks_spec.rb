require 'rails_helper'

RSpec.describe "MyFavoriteBlocks", type: :system do
  let(:my_favorite_block) { MyFavoriteBlock.last }
  let(:factory_my_favorite_block) { create(:my_favorite_block) }

  let(:my_profile) { Profile.last }
  let(:others_profile) { Profile.second }

  let(:over_fifteen_words) { 'あ' * 16 }

  # 編集画面まで遷移
  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_profiles_path
    find('#profile-edit-button').click
  end

  context 'いくつかの項目を入力したとき' do
    before do
      find('#edit-my-favorite-block-button').click
      expect(page).to have_selector('#edit-my-favorite-block-container'), 'My Favorites ブロック編集モーダルが表示されていません'
      fill_in "anime-manga-form",	with: "reゼロ"
      fill_in "game-app-form",	with: "リングフィットアドベンチャー"
      fill_in "actor-form",	with: "新垣結衣"
      find('#update-my-favorite-block-button').click
    end
    it '入力した項目が表示されること' do
      expect(page).to have_content('漫画・アニメ')
      expect(page).to have_content('reゼロ')
      expect(page).to have_content('ゲーム・アプリ')
      expect(page).to have_content('リングフィットアドベンチャー')
      expect(page).to have_content('俳優・女優')
      expect(page).to have_content('新垣結衣')
    end

    it '入力した項目が詳細ページに表示されること' do
      visit "/profiles/#{my_profile.id}"
      expect(page).to have_content('漫画・アニメ')
      expect(page).to have_content('reゼロ')
      expect(page).to have_content('ゲーム・アプリ')
      expect(page).to have_content('リングフィットアドベンチャー')
      expect(page).to have_content('俳優・女優')
      expect(page).to have_content('新垣結衣')
    end

    it '入力した項目が他人の詳細ページに表示されないこと' do
      visit "/profiles/#{others_profile.id}"
      expect(page).not_to have_content('漫画・アニメ')
      expect(page).not_to have_content('reゼロ')
      expect(page).not_to have_content('ゲーム・アプリ')
      expect(page).not_to have_content('リングフィットアドベンチャー')
      expect(page).not_to have_content('俳優・女優')
      expect(page).not_to have_content('新垣結衣')
    end
  end

  context "アップデートせずモーダルを閉じたとき" do
    before do
      find('#edit-my-favorite-block-button').click
      expect(page).to have_content('My Favorites 編集'), 'My Favorites ブロック編集モーダルが表示されていません'
      fill_in "anime-manga-form",	with: "reゼロ"
      fill_in "game-app-form",	with: "リングフィットアドベンチャー"
      fill_in "actor-form",	with: "新垣結衣"
      find('#cancel-edit-my-favorite-block-button').click
    end
    it 'モーダルが閉じること' do
      expect(page).not_to have_content('My Favorites 編集'), 'My Favorites ブロック編集モーダルが表示されています'
    end
    it '再度モーダルを開くと入力した値がリセットされていること' do
      find('#edit-my-favorite-block-button').click
      expect(page).not_to have_content('reゼロ')
      expect(page).not_to have_content('リングフィットアドベンチャー')
      expect(page).not_to have_content('新垣結衣')
    end
  end

  context '全ての項目に15文字以上で入力した場合' do
    before do
      find('#edit-my-favorite-block-button').click
      expect(page).to have_content('My Favorites 編集'), 'My Favorites ブロック編集モーダルが表示されていません'
      fill_in "anime-manga-form",	with: over_fifteen_words
      sleep 1
      fill_in "anime-manga-form",	with: over_fifteen_words
      fill_in "game-app-form",	with: over_fifteen_words
      sleep 1
      fill_in "game-app-form",	with: over_fifteen_words
      fill_in "character-form",	with: over_fifteen_words
      sleep 1
      fill_in "character-form",	with: over_fifteen_words
      fill_in "actor-form",	with: over_fifteen_words
      sleep 1
      fill_in "actor-form",	with: over_fifteen_words
      fill_in "music-form",	with: over_fifteen_words
      sleep 1
      fill_in "music-form",	with: over_fifteen_words
      fill_in "food-form",	with: over_fifteen_words
      sleep 1
      fill_in "food-form",	with: over_fifteen_words
      fill_in "animal-form",	with: over_fifteen_words
      sleep 1
      fill_in "animal-form",	with: over_fifteen_words
      fill_in "sports-form",	with: over_fifteen_words
      sleep 1
      fill_in "sports-form",	with: over_fifteen_words
      fill_in "book-form",	with: over_fifteen_words
      sleep 1
      fill_in "book-form",	with: over_fifteen_words
      fill_in "place-form",	with: over_fifteen_words
      sleep 1
      fill_in "place-form",	with: over_fifteen_words
      fill_in "snack-form",	with: over_fifteen_words
      sleep 1
      fill_in "snack-form",	with: over_fifteen_words
      fill_in "alcohol-drink-form",	with: over_fifteen_words
      sleep 1
      fill_in "alcohol-drink-form",	with: over_fifteen_words
      fill_in "restaurants-form",	with: over_fifteen_words
      sleep 1
      fill_in "restaurants-form",	with: over_fifteen_words
      fill_in "musician-form",	with: over_fifteen_words
      sleep 1
      fill_in "musician-form",	with: over_fifteen_words
      fill_in "youtuber-form",	with: over_fifteen_words
      sleep 1
      fill_in "youtuber-form",	with: over_fifteen_words
      fill_in "entertainer-form",	with: over_fifteen_words
      sleep 1
      fill_in "entertainer-form",	with: over_fifteen_words
    end
    it '全ての項目にバリデーションメッセージが表示されること' do
      expect(all('.text-red-400').size).to eq(16) # 現在16項目
    end
  end
end
