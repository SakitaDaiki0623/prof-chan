# User callbacks
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :authenticate_user!
    def slack
      raise "request.env[omniauth.auth]がありません" if request.env['omniauth.auth'].nil?
      user_info = request.env['omniauth.strategy'].access_token.user_token.get('/api/users.identity').parsed
      @user = User.from_omniauth(request.env['omniauth.auth'], user_info)

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
      else
        redirect_to root_path
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
