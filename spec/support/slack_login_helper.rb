module SlackLoginHelper
  def slack_login_first_time
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # Devise使用時に必要な記載
    Rails.application.env_config["omniauth.auth"] = set_slack_omniauth # omniauth.authの値を代入
    allow_any_instance_of(ApplicationController).to receive(:get_user_info).and_return(set_user_info) # strategy.authの値を代入
    visit root_path
    click_on 'Slackログイン'
    expect(current_path).to eq(new_profile_path), 'プロフィール新規作成画面にアクセスしていません'
  end
end