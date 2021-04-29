require 'rails_helper'

RSpec.describe "BasicBlocks", type: :system do

  let!(:profile) { create(:profile) }
  let!(:my_profile) { create(:profile, :my_profile) }

  let(:last_profile) { Profile.last }

  # 編集画面まで遷移
  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_profiles_path
    find('#profile-edit-button').click
  end

  context '編集ボタンを押したとき' do
    before do
      sleep 1
      expect(page).not_to have_selector("#edit-basic-prof-card-dialog")
      find("#edit-basic-prof-card-button").click
    end

    it '編集ダイアログが開けること' do
      expect(page).to have_selector("#edit-basic-prof-card-dialog")
    end
  end

  context '「✖︎」ボタンを押したとき' do
    before do
      find("#edit-basic-prof-card-button").click
      find("#cancel-basic-prof-card-button").click
    end
    it '編集ダイアログが閉じること' do
      sleep 1
      expect(page).not_to have_selector("#edit-basic-prof-card-dialog")
    end
  end

  context '内容を全部変更したときに' do
    before do
      find("#edit-basic-prof-card-button").click
      expect(page).to have_content(my_profile.gender_i18n)
      expect(page).to have_content(my_profile.height)
      expect(page).to have_content(my_profile.blood_type)
      expect(page).to have_content(my_profile.prefecture.name)
      expect(page).to have_content(my_profile.birthday.strftime("%Y/%m/%d"))
      expect(page).to have_content(my_profile.day_of_joinning.strftime("%Y/%m/%d"))

      select profile.gender_i18n, from: 'profile_gender'
      fill_in 'profile_height',	with: profile.height
      select profile.blood_type, from: 'profile_blood_type'
      select profile.prefecture.name, from: 'profile_prefecture_id'
      fill_in 'profile_birthday',	with: profile.birthday
      fill_in 'profile_day_of_joinning',	with: profile.day_of_joinning
      click_on'基本情報を更新！'
    end
    it '変更した内容が全て反映されること' do
      expect(page).not_to have_selector("#edit-basic-prof-card-dialog")
      sleep 1
      expect(page).to have_content(profile.gender_i18n)
      expect(page).to have_content(profile.height)
      expect(page).to have_content(profile.blood_type)
      expect(page).to have_content(profile.prefecture.name)
      expect(page).to have_content(profile.birthday.strftime("%Y/%m/%d"))
      expect(page).to have_content(profile.day_of_joinning.strftime("%Y/%m/%d"))
    end

    it '変更した内容が詳細ページにも反映されること' do
      visit "/profiles/#{last_profile.id}"
      expect(page).to have_content(profile.gender_i18n)
      expect(page).to have_content(profile.height)
      expect(page).to have_content(profile.blood_type)
      expect(page).to have_content(profile.prefecture.name)
      expect(page).to have_content(profile.birthday.strftime("%Y/%m/%d"))
      expect(page).to have_content(profile.day_of_joinning.strftime("%Y/%m/%d"))
    end
  end
end
