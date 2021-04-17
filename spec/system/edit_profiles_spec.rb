require 'rails_helper'

RSpec.describe 'EditProfile', type: :system do

  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_profiles_path
  end

  let(:my_profile) { Profile.last }
  let(:other_profile) { Profile.first }

  describe 'ページの基本検証' do
    before {find("#profile-edit-button").click}

    fit 'タイトルが「プロフィール編集 - プロフちゃん」であること' do
      expect(page).to have_title('プロフィール編集 - プロフちゃん'), '意図したタイトルが表示されていません'
    end

    it '自分のプロフィール編集画面であること' do
      expect(page).to have_content(my_profile)
    end
  end
end
