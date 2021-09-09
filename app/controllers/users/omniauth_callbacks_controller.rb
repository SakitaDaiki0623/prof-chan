# User callbacks
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :authenticate_user!, only: %i[slack failure]

    def slack
      @user = User.from_omniauth(auth, bot_token)

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

    private

    def auth
      request.env['omniauth.auth']
    end

    def bot_token
      request.env['omniauth.strategy'].access_token
    end
  end
end
