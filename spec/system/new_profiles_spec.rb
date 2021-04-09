require 'rails_helper'

RSpec.describe 'NewProfiles', type: :system do

  # let
  let(:profile) { create(:profile) }

  before { slack_login_first_time }

  describe 'ページの基本検証' do
    it 'タイトルが「プロフィールづくり - プロフちゃん」であること' do
      expect(page).to have_title('プロフィールづくり - プロフちゃん'), '意図したタイトルが表示されていません'
    end

    it 'ログアウトボタンが表示されていないこと' do
      expect(page).not_to have_content('ログアウト'), 'ログアウトボタンが表示されています' 
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
    context '何も入力していないとき' do
      it 'ボタンがdisabledであること' do
        expect(page).to have_button '入力完了！', disabled: true
      end
    end
    context '性別が未入力の時' do
      before do
        fill_in 'profile_height',    with: ''
        # 別項目の入力
        select profile.blood_type, from: 'profile_blood_type'
      end
      it 'バリデーションエラーメッセージが表示されること' do
        expect(page).to have_content('身長を入力してね'), 'エラーメッセージが表示されていません'
        expect(page).to have_button '入力完了！', disabled: true
      end
    end
    context '誕生日が未入力の時' do
      before do
        fill_in 'profile_birthday',	with: ''
        select profile.blood_type, from: 'profile_blood_type'
      end
      it 'バリデーションエラーメッセージが表示されること' do
        expect(page).to have_content('生年月日を入力してね'), 'エラーメッセージが表示されていません'
        expect(page).to have_button '入力完了！', disabled: true
      end
    end
    context '入社日が未入力の時' do
      before do
        fill_in 'profile_day_of_joinning', with: ''
        select profile.blood_type, from: 'profile_blood_type'
      end
      it 'バリデーションエラーメッセージが表示されること' do
        expect(page).to have_content('入社日を入力してね'), 'エラーメッセージが表示されていません'
        expect(page).to have_button '入力完了！', disabled: true
      end
    end
  end

  describe 'Authorization' do
    context 'ホーム画面に遷移したと場合' do
      before { visit root_path }
      it 'プロフィール作成画面にアクセスすること' do
        expect(current_path).to eq(new_profile_path), 'パスがnew_profile_pathではありません'
      end
    end

    context 'プロフィール一覧画面に遷移したと場合' do
      before { visit profiles_path }
      it 'プロフィール作成画面にアクセスすること' do
        expect(current_path).to eq(new_profile_path), 'パスがnew_profile_pathではありません'
      end
    end
  end
end
