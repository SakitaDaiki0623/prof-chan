# app/controllers/user_sessions_controller.rb
class UserSessionsController < ApplicationController
  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to(:root, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:root, notice: 'Logged out!')
  end
end