# app/controllers/home_controller.rb
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  layout 'top'

  # TODO: Refactoring
  # user_signed_in?を2度書くのが冗長
  def index
    if user_signed_in? && current_user.profile.nil?
      redirect_to new_profile_path
    elsif user_signed_in?
      redirect_to profiles_path
    end
  end
end
