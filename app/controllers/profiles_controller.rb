class ProfilesController < ApplicationController
  before_action :check_profile_presence, only: %i[new create]
  skip_before_action :check_profile_nil, only: %i[new create]

  layout 'new_profiles', only: %i[new create]

  def index
    user = User.find(current_user.id)
    @profiles = Profile.includes(user: :team).where(teams: { workspace_id: user.team.workspace_id })
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      flash[:notice] = 'プロフィール作成が完了しました'
      redirect_to profiles_path
    else
      flash.now[:alert] = 'プロフィール作成に失敗しました'
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

  def check_profile_presence
    if current_user.profile.present?
      flash[:notice] = '基本情報はもう作ったよ！'
      redirect_to profiles_path
    end
  end

  def profile_params
    params.require(:profile).permit(:birthday, :day_of_joinning, :introduction, :height, :gender, :blood_type, :prefecture_id)
  end
end
