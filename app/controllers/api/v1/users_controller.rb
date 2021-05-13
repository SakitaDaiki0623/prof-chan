module Api
  module V1
    class UsersController < ApiController
      before_action :set_user, only: %i[show]

      def index
        @user = User.find(current_user.id)
        @users = User.includes(:team).where(teams: { workspace_id: @user.team.workspace_id })
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @users,
          serializer: UserSerializer
        ).to_json
      end

      def show
        render json: @user
      end

      def new; end

      def get_current_user
        @user = User.find(current_user.id)
        render json: @user, serializer: UserSerializer
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
