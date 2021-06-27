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

      # Share right
      def update_question_share_right
        return if @user.share_right.question_inactive?

        @user.share_right.question_inactive!
        render json: @user, serializer: UserSerializer
      end

      def update_ranking_share_right
        return if @user.share_right.ranking_inactive?

        @user.share_right.ranking_inactive!
        render json: @user, serializer: UserSerializer
      end

      def update_yes_or_no_share_right
        return if @user.share_right.yes_or_no_inactive?

        @user.share_right.yes_or_no_inactive!
        render json: @user, serializer: UserSerializer
      end

      def update_text_share_right
        return if @user.share_right.text_inactive?

        @user.share_right.text_inactive!
        render json: @user, serializer: UserSerializer
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
        params.require(:user).permit(:name, :image, :email, :role)
      end
    end
  end
end
