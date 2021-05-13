# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Pundit
  include ErrorRenderable
  before_action :authenticate_user!

  # エラーハンドリング =============
  rescue_from Exception, with: :notify_500
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private
  # Divise認証時に分岐
  def after_sign_in_path_for(user)
    if user.profile
      top_path
    else
      new_profile_path
    end
  end
end
