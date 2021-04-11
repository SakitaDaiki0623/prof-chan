require 'rails_helper'

RSpec.describe 'NewProfiles', type: :system do

  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_profiles_path
  end

  describe 'ページの基本検証', focus: true do
    let(:profile) { Profile.last }

    before { find("#profile-index-card-#{profile.id}").click }

    it 'タイトルが「プロフィール詳細 - プロフちゃん」であること' do
      expect(page).to have_title('プロフィール詳細 - プロフちゃん'), '意図したタイトルが表示されていません'
    end

    it '指定のプロフィールが表示されていること' do
      expect(page).to have_content("#{profile.user.name} さんのプロフィール")
    end
  end

  describe 'プロフィール情報を正確に入力' do
    before do
      select '男性', from: 'profile_gender'
      fill_in 'profile_height',	with: profile.height
      select profile.blood_type, from: 'profile_blood_type'
      # Active_hashのためprofile_idは外部キーの値となってしまう
      select profile.prefecture.name, from: 'profile_prefecture_id'
      fill_in 'profile_birthday',	with: profile.birthday
      fill_in 'profile_day_of_joinning',	with: profile.day_of_joinning
      click_on '入力完了！'
      sleep 1
    end
    it 'プロフィール一覧にアクセスすること' do
      expect(page).to have_content('基本情報の登録が完了しました！'), '意図したメッセージが表示されていません'
      expect(page).to have_button('他の情報も入力する'), 'プロフィール編集画面へのボタンがありません'
      expect(page).to have_button('プロフィール閲覧'), 'プロフィール一覧画面へのボタンがありません'
    end
  end

  # TODO: selectについてはバリデーションエラーの表示をさせる方法が不明
  describe 'バリデーション' do
  end
end
