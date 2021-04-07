class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @user = User.find(current_user.id)
    @users = User.includes(:team).where(teams: { workspace_id: @user.team.workspace_id })
    render json: ActiveModel::Serializer::CollectionSerializer.new(
      @users,
      serializer: UserSerializer
    ).to_json
  end

  def show
    @user = User.find(current_user.id)
    render json: @user
  end
end
