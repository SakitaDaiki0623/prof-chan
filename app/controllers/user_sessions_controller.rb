# app/controllers/user_sessions_controller.rb
class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create new]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      if @user.profile.present?
        redirect_to profiles_path, notice: 'ログインに成功しました'
      else
        redirect_to new_profile_path
      end
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:root, notice: 'ログアウトしました')
  end
end
