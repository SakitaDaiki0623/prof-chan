# app/controllers/api/v1/profile_blocks_controller.rb
module Api
  module V1
    class ProfileBlocksController < ApiController
      before_action :set_profile_block, only: %i[show]

      def index
        @user = User.find(current_user.id)
        @profile_blocks = ProfileBlock.includes(user: :team).where(teams: { workspace_id: @user.team.workspace_id })
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @profile_blocks,
          serializer: ProfileBlockSerializer
        ).to_json
      end

      def show
        render json: @profile_block, serializer: ProfileBlockSerializer
      end

      private

      def set_profile_block
        @profile_block = ProfileBlock.find(params[:id])
      end
    end
  end
end
