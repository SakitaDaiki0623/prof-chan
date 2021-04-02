require 'rails_helper'

RSpec.describe "NewProfiles", type: :system do

  let(:profile) { create(:profile) }

  before { slack_login_first_time }

  context 'ページの基本検証' do
    it 'タイトルが「プロフィールづくり - プロフちゃん」であること' do
      expect(page).to have_title('プロフィールづくり - プロフちゃん'), '意図したタイトルが表示されていません'
    end

    it 'ログアウトボタンが表示されていないこと' do
      expect(page).not_to have_content('ログアウト'), 'ログアウトボタンが表示されています' 
    end
  end

  context 'プロフィール情報が正確に入力された時' do
    before do
      fill_in 'profile_height',	with: profile.height
      select profile.blood_type, from: 'profile_blood_type'
      # Active_hashのためprofile_idは外部キーの値となってしまう
      select profile.prefecture.name, from: 'profile_prefecture_id'
      select '男性', from: 'profile_gender'
      fill_in 'profile_birthday',	with: profile.birthday
      fill_in 'profile_day_of_joinning',	with: profile.day_of_joinning
    end
    it "プロフィール一覧にアクセスすること" do
      expect{ click_on '入力完了！' }.to change(Profile, :count).by(1), 'プロフィール数が1つ増えていません'
      expect(page).to have_content('プロフィール作成が完了しました'), 'フラッシュメッセージが表示されていません'
      expect(page).to have_content('ログアウト'), 'ログアウトボタンが表示されていません'
    end
  end

  describe "バリデーション" do
    context "何も入力せずに「入力完了！」を押した場合" do
      before { click_on '入力完了！'  }
      it '新規プロフィール作成画面がレンダーされる' do
        expect(current_path).to eq(profiles_path), 'パスがprofiles_pathではありません'
        expect(page).to have_content('プロフィール作成に失敗しました'), 'フラッシュメッセージが表示されていません'
      end
    end
  end

  describe "プロフィールを作成せずに他のページにアクセスする" do
    context 'profiles_path' do
      before { visit profiles_path }
      it "プロフィール一覧にアクセスすること" do
        expect(current_path).to eq(new_profile_path), 'パスがnew_profile_pathではありません'
        expect(page).to have_content('まずは基本情報を作ろう！'), 'フラッシュメッセージが表示されていません'
      end
    end
  end
end
