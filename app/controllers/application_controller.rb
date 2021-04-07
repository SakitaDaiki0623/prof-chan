class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def get_user_info(request)
    request.access_token.user_token.get('/api/users.identity').parsed
  end

  # Divise認証時に分岐
  def after_sign_in_path_for(user)
    if user.profile
      profiles_path
    else
      new_profile_path
    end
  end

  def check_profile_nil
    if current_user.profile.nil?
      binding.pry
      flash[:alert] = 'まずは基本情報を作ろう！'
      redirect_to new_profile_path
    end
  end
end
