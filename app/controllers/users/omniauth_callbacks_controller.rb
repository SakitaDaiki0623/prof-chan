# User callbacks
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :authenticate_user!, only: %i[slack failure]
    def slack
      user_info = get_user_info(request.env['omniauth.strategy'])
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
