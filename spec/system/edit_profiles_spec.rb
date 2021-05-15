require 'rails_helper'

RSpec.describe 'EditProfile', type: :system do

  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_top_path
  end

  let(:my_profile) { Profile.last }
  let(:other_profile) { Profile.first }

  let(:other_profile_edit_path) { "profiles/#{other_profile.id}/edit" }

  describe 'ページの基本検証' do
    before {find("#profile-edit-button").click}

    it 'タイトルが「プロフ編集 - プロフちゃん」であること' do
      expect(page).to have_title('プロフ編集 - プロフちゃん'), '意図したタイトルが表示されていません'
    end

    it 'ヘッダーが表示されていないこと' do
      expect(page).to have_selector('header'), 'ヘッダーが表示されています'
    end

    it '自分のプロフ編集画面であること' do
      expect(page).to have_content(my_profile.user.name)
    end

    it '編集ボタンが表示されていること' do
      expect(page).to have_selector('#edit-basic-prof-card-button')
      expect(page).to have_selector('#edit-address-block-button')
      expect(page).to have_selector('#edit-my-favorite-block-button')
    end
    it 'ブロック追加ボタンが表示されていること' do
      expect(page).to have_selector('#add-text-block-btn')
      expect(page).to have_selector('#add-ranking-block-btn')
      expect(page).to have_selector('#add-question-block-btn')
      expect(page).to have_selector('#add-yes-or-no-block-btn')
    end
  end

  describe 'Authorization' do
    context '他人の編集ページにアクセスしようとした時' do
      before { visit other_profile_edit_path }
      it '自分のプロフ編集
      ページにリダイレクトすること' do
        expect(current_path).to eq("/profiles/#{my_profile.id}/edit")
        expect(page).to have_content('他の人のプロフは編集できないよ！')
      end
    end
  end
end
