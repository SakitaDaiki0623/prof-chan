require 'rails_helper'

RSpec.describe 'ProfilesPage', type: :system do

  let(:user) {build(:user, :real_workspace_id)}

  before do
    create_real_team_with_users(users_count: 3)
    create_normal_team_with_users(users_count: 3)
    login
  end

  describe 'ページの基本検証' do
    it 'タイトルが「プロフ一覧 - プロフちゃん」であること' do
      expect(page).to have_title('プロフ一覧 - プロフちゃん'), '意図したタイトルが表示されていません'
    end

    it 'ヘッダーが表示されていること' do
      expect(page).to have_selector('header'), 'ヘッダーが表示されていません'
    end
  end

  describe '他のチームのプロフが閲覧できないことを確認確認' do
    it '自分のチームのプロフのみが表示されていること' do
      sleep 1
      team_profile_size = Profile.includes(user: :team).where(teams: { workspace_id: user.team.workspace_id }).count
      expect(team_profile_size).to eq(all('.bg-prof-card').count), '画面に表示されているプロフが意図した数と異なります'
    end
  end


  describe 'Authorization' do
    context 'ホーム画面に遷移したと場合' do
      before { visit root_path }
      it 'プロフ作成画面にアクセスすること' do
        expect(current_path).to eq(top_path), 'パスがtop_pathではありません'
      end
    end

    context 'プロフ作成画面に遷移したと場合' do
      before { visit new_profile_path }
      it 'プロフ作成画面にアクセスすること' do
        expect(current_path).to eq(top_path), 'パスがtop_pathではありません'
      end
    end
  end
end
