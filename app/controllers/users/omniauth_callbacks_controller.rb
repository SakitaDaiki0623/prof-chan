# User callbacks
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def slack
    
    binding.pry
    
    @user = User.from_omniauth(request.env['omniauth.auth'], request.env['omniauth.strategy'])

    if @user.persisted?
      if @user.profile.present?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Slack') if is_navigational_format?
      else
        redirect_to new_profile_path
      end
    else
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end