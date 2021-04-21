module Api
  module V1
    class UsersController < ApiController

      def index
        @user = User.find(current_user.id)
        @users = User.includes(:team).where(teams: { workspace_id: @user.team.workspace_id })
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @users,
          serializer: UserSerializer
        ).to_json
      end

      def show; end

      # [TODO: Refactor] current_userの取得するメソッド名を変更
      def new
        @user = User.find(current_user.id)
        render json: @user, serializer: UserSerializer
      end
    end
  end
end
