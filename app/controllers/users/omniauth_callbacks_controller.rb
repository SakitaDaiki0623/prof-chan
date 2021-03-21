# User callbacks
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_user!
  def slack

    @user_token = request.env['omniauth.strategy'].access_token.user_token
    @user = User.from_omniauth(request.env['omniauth.auth'], @user_token)

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