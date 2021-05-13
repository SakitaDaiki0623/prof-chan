# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!

  # エラーハンドリング =============
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def get_user_info(request)
    request.access_token.user_token.get('/api/users.identity').parsed
  end

  # Divise認証時に分岐
  def after_sign_in_path_for(user)
    if user.profile
      top_path
    else
      new_profile_path
    end
  end

  private

  def user_not_authorized
    redirect_to(request.referer || root_path)
  end
end
