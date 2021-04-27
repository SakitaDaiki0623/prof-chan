require 'rails_helper'

RSpec.describe 'ShowProfile', type: :system do

  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_profiles_path
  end

  let(:my_profile) { Profile.last }
  let(:others_profile) { Profile.first }

  describe 'ページの基本検証' do

    before { find("#profile-index-card-#{my_profile.id}").click }

    it 'タイトルが「プロフィール詳細 - プロフちゃん」であること' do
      expect(page).to have_title('プロフィール詳細 - プロフちゃん'), '意図したタイトルが表示されていません'
    end

    it '指定のプロフィールが表示されていること' do
      expect(page).to have_content("#{my_profile.user.name} さんのプロフィール")
    end

    it 'ヘッダーが表示されていること' do
      expect(page).to have_selector('header'), 'ヘッダーが表示されていません'
    end
  end

  describe '自分の詳細ページ' do

    before { find("#profile-index-card-#{my_profile.id}").click }

    it '編集ボタンが表示されていること' do
      sleep 1
      expect(page).to have_button('編集する')
    end
  end

  describe '他人の詳細ページ' do

    before { find("#profile-index-card-#{others_profile.id}").click }

    it '編集ボタンが表示されていないこと' do
      expect(page).not_to have_button('編集する')
    end
  end
end
