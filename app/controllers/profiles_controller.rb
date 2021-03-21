class ProfilesController < ApplicationController

  def index; end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      flash[:success] = 'プロフィール作成が完了しました'
      redirect_to profiles_path
    else
      flash.now[:danger] = 'プロフィール作成に失敗しました'
      render :new
    end
  end

  def edit; end

  def show; end

  def update; end

  def destroy; end

  def new
    @profile = current_user.build_profile
  end

  private

  def profile_params
    params.require(:profile).permit(:birthday, :day_of_joinning, :introduction, :height, :gender)
  end
end
