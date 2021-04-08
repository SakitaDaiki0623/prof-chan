require 'rails_helper'

RSpec.describe 'ProfilesPage', type: :system do

  # let

  before { slack_login_til_access_profiles_path }

  describe 'ページの基本検証' do
    it 'タイトルが「プロフィール一覧 - プロフちゃん」であること' do
      expect(page).to have_title('プロフィール一覧 - プロフちゃん'), '意図したタイトルが表示されていません'
    end
    it 'ログアウトが表示されていること' do
      expect(page).to have_content('ログアウト'), 'ログアウトボタンが表示されていません'
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
