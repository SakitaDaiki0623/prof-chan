# User callbacks
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :authenticate_user!, only: %i[slack failure]
    include SlackApiActivatable

    def slack
      bot_token = request.env['omniauth.strategy'].access_token
      user_token = bot_token.user_token
      user_info = get_user_info(user_token)
      create_channel(user_info, bot_token)

      @user = User.from_omniauth(request.env['omniauth.auth'], user_info)

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
