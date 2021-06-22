class ProfilesController < ApplicationController
  def index
    authorize Profile
  end

  def new
    authorize Profile
  end

  def top
    redirect_to new_profile_path if current_user.profile.nil?
  end

  private

  def profile_params
    params.require(:profile).permit(:birthday, :day_of_joinning, :height, :gender, :blood_type, :prefecture_id)
  end
end
