# app/controllers/home_controller.rb
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  layout 'top'
  def index
    if user_signed_in?
      redirect_to profiles_path
    end
  end
end
