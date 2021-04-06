class ProfilesController < ApplicationController
  before_action :check_profile_presence, only: %i[new create]
  skip_before_action :check_profile_nil, only: %i[new create]

  def index; end

  def new; end

  private

  def check_profile_presence
    if current_user.profile.present?
      flash[:notice] = '基本情報はもう作ったよ！'
      redirect_to profiles_path
    end
  end

  def profile_params
    params.require(:profile).permit(:birthday, :day_of_joinning, :height, :gender, :blood_type, :prefecture_id)
  end
end
