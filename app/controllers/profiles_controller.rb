class ProfilesController < ApplicationController
  before_action :check_profile_present, only: %i[new create]

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

  def check_profile_present
    redirect_to profiles_path if current_user.profile.present?
  end

  def profile_params
    params.require(:profile).permit(:birthday, :day_of_joinning, :introduction, :height, :gender, :blood_type, :prefecture_id)
  end
end
