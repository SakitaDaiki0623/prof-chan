# app/controllers/home_controller.rb
class HomeController < ApplicationController
  skip_before_action :require_login

  def index; end
end
