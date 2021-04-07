class Api::V1::ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token
  # skip_before_action :check_profile_nil, only: %i[index new]

  def index
    @user = User.find(current_user.id)
    @profiles = Profile.includes(user: :team).where(teams: { workspace_id: @user.team.workspace_id })
    render json: ActiveModel::Serializer::CollectionSerializer.new(
      @profiles,
      serializer: ProfileSerializer
    ).to_json
  end

  def create

    @profile = current_user.build_profile(profile_params)

    if @profile.save
      render json: @profile
    else
      render json: @profile.errors, status: :bad_request
    end
  end

  def show; end

  def update; end

  def destroy; end

  def new
    @user = User.find(current_user.id)
    render json: @user
  end

  # def check_profile_presence
  #   if current_user.profile.present?
  #     flash[:notice] = '基本情報はもう作ったよ！'
  #     redirect_to profiles_path
  #   end
  # end

  def profile_params
    params.require(:profile).permit(:birthday, :day_of_joinning, :height, :gender, :blood_type, :prefecture_id)
  end
end
