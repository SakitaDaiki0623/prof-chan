require 'rails_helper'

RSpec.describe "SlackLogin", type: :system do

  describe "失敗" do
    before do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      Rails.application.env_config["omniauth.auth"] = set_slack_omniauth
      allow_any_instance_of(Users::OmniauthCallbacksController).to receive(:get_user_info).and_return(get_user_info)
    end
    context 'oauthがinvalid_omniauthの場合' do
      before do
        Rails.application.env_config["omniauth.auth"] = set_invalid_omniauth
        visit root_path
        find("#agreement-path-button").click
        expect(current_path).to eq(agreement_path)
        find("#agreement").click
        find("#sign-in-with-slack-button").click
      end
      it "トップページにリダイレクトされること" do
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Slack認証に失敗しました。')
      end
    end
  end

  context '初めてアプリにログインする時' do
    before do
      visit root_path
      find("#agreement-path-button").click
      expect(current_path).to eq(agreement_path)
      find("#agreement").click
    end
    it 'プロフィール新規作成画面にアクセスすること' do
      find("#sign-in-with-slack-button").click
      expect(current_path).to eq(new_profile_path), 'パスがnew_profile_pathではありません'
    end
  end

  context 'プロフィールを作成して再度ログインする時' do
    before do
      slack_login_first_time
      create_profile
      expect(current_path).to eq(top_path), 'パスがtop_pathではありません'
      expect(page).to have_content('ログアウト'), 'ログアウトボタンが表示されていません'
      click_on 'ログアウト'
      expect(current_path).to eq(root_path), 'パスがroot_pathではありません'
      expect{ find("#sign-in-with-slack-button").click }.to change(User, :count).by(0), 'ユーザー数が1人増えています'
    end
    it 'プロフィール一覧画面にリダイレクトされること' do
      expect(current_path).to eq(top_path), 'パスがtop_pathではありません'
    end
  end
end
