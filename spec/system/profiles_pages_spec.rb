require 'rails_helper'

RSpec.describe 'ProfilesPage', type: :system do

  let(:user) {build(:user, :real_workspace_id)}

  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_profiles_path
  end

  describe 'ページの基本検証' do
    it 'タイトルが「プロフィール一覧 - プロフちゃん」であること' do
      expect(page).to have_title('プロフィール一覧 - プロフちゃん'), '意図したタイトルが表示されていません'
    end

    it 'ヘッダーが表示されていること' do
      expect(page).to have_selector('header'), 'ヘッダーが表示されていません'
    end
  end

  describe '他のチームのプロフィールが閲覧できないことを確認確認' do
    it '他のチームのプロフィールが表示されていないこと' do
      sleep 1
      team_profile_size = Profile.includes(user: :team).where(teams: { workspace_id: user.team.workspace_id }).count
      expect(team_profile_size).to eq(all('.bg-prof-card').count), '画面に表示されているプロフィールが意図した数と異なります'
    end
  end


  describe 'Authorization' do
    context 'ホーム画面に遷移したと場合' do
      before { visit root_path }
      it 'プロフィール作成画面にアクセスすること' do
        expect(current_path).to eq(profiles_path), 'パスがprofiles_pathではありません'
      end
    end

    context 'プロフィール作成画面に遷移したと場合' do
      before { visit new_profile_path }
      it 'プロフィール作成画面にアクセスすること' do
        expect(current_path).to eq(profiles_path), 'パスがprofiles_pathではありません'
      end
    end
  end
end
