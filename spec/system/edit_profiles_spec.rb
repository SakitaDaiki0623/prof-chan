require 'rails_helper'

RSpec.describe 'EditProfile', type: :system do

  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_profiles_path
  end

  let(:my_profile) { Profile.last }
  let(:other_profile) { Profile.first }

  let(:other_profile_edit_path) { "profiles/#{other_profile.id}/edit" }

  describe 'ページの基本検証' do
    before {find("#profile-edit-button").click}

    it 'タイトルが「プロフィール編集 - プロフちゃん」であること' do
      expect(page).to have_title('プロフィール編集 - プロフちゃん'), '意図したタイトルが表示されていません'
    end

    it 'ヘッダーが表示されていないこと' do
      expect(page).to have_selector('header'), 'ヘッダーが表示されています'
    end

    it '自分のプロフィール編集画面であること' do
      expect(page).to have_content(my_profile.user.name)
    end
  end

  describe 'Authorization' do
    context '他人の編集ページにアクセスしようとした時' do
      before { visit other_profile_edit_path }
      it 'プロフィールページにリダイレクトすること' do
        expect(current_path).to eq("/profiles/#{my_profile.id}/edit")
        expect(page).to have_content('他の人のプロフィールは編集できないよ！')
      end
    end
  end
end
