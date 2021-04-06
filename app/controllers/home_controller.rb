# app/controllers/home_controller.rb
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  skip_before_action :check_profile_nil, only: %i[index]
  layout 'top'
  def index
    if user_signed_in?
      redirect_to profiles_path
    end
  end
end
