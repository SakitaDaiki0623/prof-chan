# spec/system/slack_login_spec.rb
require 'rails_helper'

RSpec.describe "SlackLogin", type: :system do

  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # Devise使用時に必要な記載
    Rails.application.env_config["omniauth.auth"] = set_slack_omniauth # omniauth.authの値を代入
    allow_any_instance_of(ApplicationController).to receive(:get_user_info).and_return(set_user_info) # strategy.authの値を代入
  end

  context 'oauthがinvali_omniauthの場合' do
    before do
      Rails.application.env_config["omniauth.auth"] = set_invalid_omniauth
      visit root_path
      click_on 'Slackログイン'
    end
    it "トップページにリダイレクトされる" do
      expect(current_path).to eq(root_path), 'ルートパスにリダイレクトされていません'
      expect(page).to have_content('Slack認証に失敗しました。'), 'フラッシュメッセージが表示されていません'
    end
  end

  context '初めてアプリにログインする時' do
    before do
      visit root_path
    end
    it 'プロフィール新規作成画面にアクセスする' do
      expect{ click_on "Slackログイン" }.to change(User, :count).by(1), 'ユーザー数が1人増えていません'
      expect(current_path).to eq(new_profile_path), 'プロフィール新規作成画面にアクセスしていません'
    end
  end

  context 'プロフィールを作成して再度ログインする時' do
    before do
      slack_login_first_time
      create_profile
      expect(current_path).to eq(profiles_path), 'パスがprofiles_pathではありません'
      expect(page).to have_content('ログアウト'), 'ログアウトボタンが表示されていません'
      click_on 'ログアウト'
      expect(current_path).to eq(root_path), 'パスがroot_pathではありません'
      expect{ click_on "Slackログイン" }.to change(User, :count).by(0), 'ユーザー数が1人増えていません'
    end
    it 'プロフィール一覧画面にリダイレクトされること' do
      expect(page).to have_content('ログインに成功しました'), '意図したフラッシュメッセージが表示されていません'
      expect(current_path).to eq(profiles_path), 'パスがprofiles_pathではありません'
    end
  end

end
