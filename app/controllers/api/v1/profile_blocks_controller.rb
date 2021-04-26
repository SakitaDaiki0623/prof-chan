# app/controllers/api/v1/profile_blocks_controller.rb
module Api
  module V1
    class ProfileBlocksController < ApiController
      def index
        @user = User.find(current_user.id)
        @profile_blocks = ProfileBlock.includes(user: :team).where(teams: { workspace_id: @user.team.workspace_id })
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @profile_blocks,
          serializer: ProfileBlockSerializer
        ).to_json
      end
    end
  end
end
