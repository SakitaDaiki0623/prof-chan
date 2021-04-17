require 'rails_helper'

RSpec.describe 'TextBlock', type: :system do

  before do
    create_real_team_with_users(users_count: 15)
    create_normal_team_with_users
    slack_login_till_access_profiles_path
  end

  let(:my_profile) { Profile.last }
  let(:other_profile) { Profile.first }

  describe 'テキストブロック作成機能' do
    context '正常な値を入力した時' do
      before do
        click_on 'テキストブロックを追加する'
        fill_in "text_block_title",	with: "テキストブロック"
        fill_in "text_block_text",	with: "テキストブロック"
      end
    end
  end
end
