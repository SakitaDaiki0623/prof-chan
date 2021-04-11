require 'rails_helper'

RSpec.describe 'ShowProfile', type: :system do

  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_profiles_path
  end

  describe 'ページの基本検証' do
    let(:profile) { Profile.last }

    before { find("#profile-index-card-#{profile.id}").click }

    it 'タイトルが「プロフィール詳細 - プロフちゃん」であること' do
      expect(page).to have_title('プロフィール詳細 - プロフちゃん'), '意図したタイトルが表示されていません'
    end

    it '指定のプロフィールが表示されていること' do
      expect(page).to have_content("#{profile.user.name} さんのプロフィール")
    end
  end
end
