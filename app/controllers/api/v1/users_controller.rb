module Api
  module V1
    class UsersController < ApiController
      before_action :set_user, only: %i[show]
      before_action :set_current_user, only: %i[update_question_share_right update_ranking_share_right update_yes_or_no_share_right update_text_share_right]

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

      def update_question_share_right
        if @user.question_not_shared_yet?
          @user.question_already_shared!
          render json: @user, serializer: UserSerializer
        end
      end
      def update_ranking_share_right
        if @user.ranking_not_shared_yet?
          @user.ranking_already_shared!
          render json: @user, serializer: UserSerializer
        end
      end
      def update_yes_or_no_share_right
        if @user.yes_or_no_not_shared_yet?
          @user.yes_or_no_already_shared!
          render json: @user, serializer: UserSerializer
        end
      end
      def update_text_share_right
        if @user.text_not_shared_yet?
          @user.text_already_shared!
          render json: @user, serializer: UserSerializer
        end
      end

      def get_current_user
        @user = User.find(current_user.id)
        render json: @user, serializer: UserSerializer
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def set_current_user
        @user = User.find(current_user.id)
      end

      def user_params
        params.require(:user).permit(:name, :image, :email, :role, :share_right)
      end
    end
  end
end
