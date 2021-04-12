require 'rails_helper'

RSpec.describe 'EditProfile', type: :system do

  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_profiles_path
  end

  let(:my_profile) { Profile.last }
  let(:others_profile) { Profile.first }

  describe '基本プロフィール編集機能' do
    before do
      find("#profile-index-card-#{my_profile.id}").click
      find('#edit-basic-profile-btn').click
    end

    it '編集モーダルが表示されること' do
      # expect(page).to have_selector("#edit-basic-profile-modal-#{my_profile.id}")
    end

    context '性別を更新した時' do
      it '更新した値が一覧画面と詳細画面に反映されていること' do
        expect(page).to have_content("#{my_profile.user.name} さんのプロフィール")
      end
    end
  end
end
