module SlackLoginHelper
  def slack_login_first_time
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # Devise使用時に必要な記載
    Rails.application.env_config["omniauth.auth"] = set_slack_omniauth # omniauth.authの値を代入
    allow_any_instance_of(ApplicationController).to receive(:get_user_info).and_return(set_user_info) # strategy.authの値を代入
    visit root_path
    find("#sign_in_with_slack_button").click
    expect(current_path).to eq(new_profile_path), 'パスがnew_profile_pathではありません'
  end

  def create_profile
    expect(current_path).to eq(new_profile_path), 'パスがnew_profile_pathではありません'
    profile = create(:profile, :my_profile)
    select profile.gender_i18n, from: 'profile_gender'
    fill_in 'profile_height',	with: profile.height
    select profile.blood_type, from: 'profile_blood_type'
    select profile.prefecture.name, from: 'profile_prefecture_id'
    fill_in 'profile_birthday',	with: profile.birthday
    fill_in 'profile_day_of_joinning',	with: profile.day_of_joinning
    click_on '入力完了！'
  end

  def slack_login_till_access_top_path
    slack_login_first_time
    create_profile
    click_button 'プロフィール閲覧'
    expect(current_path).to eq(top_path), 'パスがtop_pathではありません'
    sleep 0.5
  end
end