# spec/system/slack_login_spec.rb
require 'rails_helper'

RSpec.describe "SlackLogin", type: :system do
  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # Devise使用時に必要な記載
    Rails.application.env_config["omniauth.auth"] = set_slack_omniauth # モックの値を代入
  end
  fit '「slackログイン」時のハッシュでユーザー認証ができる' do
    visit root_path
    click_on 'Slackログイン'
  end
end
