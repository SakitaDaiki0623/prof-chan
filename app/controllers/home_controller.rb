# app/controllers/home_controller.rb
class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'top'

  def index
    if user_signed_in? && current_user.profile.nil?
      redirect_to new_profile_path
    elsif user_signed_in?
      redirect_to top_path
    end
  end

  def agreement
    redirect_to top_path if user_signed_in?
  end

  def privacy; end

  def terms; end
end
