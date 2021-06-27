# User callbacks
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :authenticate_user!, only: %i[slack failure]
    include SlackApiActivatable

    def slack
      bot_token = request.env['omniauth.strategy'].access_token
      hash_token = bot_token.to_hash
      access_token = get_access_token(ENV['SLACK_CLIENT_ID'], ENV['SLACK_CLIENT_SECRET'], hash_token)
      user_token = bot_token.user_token
      user_info = get_user_info(user_token)

      # 初ログインであればチャンネル作成、招待
      channel = check_channel(user_info, request.env['omniauth.auth'], access_token)
      @user = User.from_omniauth(request.env['omniauth.auth'], user_info, hash_token, channel)

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
      else
        redirect_to root_path
      end
    end

    def failure
      flash[:alert] = 'Slack認証に失敗しました。'
      redirect_to root_path
    end
  end
end
