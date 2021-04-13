# app/controllers/api/v1/text_blocks_controller.rb
module Api
  module V1
    class TextBlocksController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        @user = User.find(current_user.id)
        @text_blocks = TextBlock.includes(profile_block: { user: :team }).where(teams: { workspace_id: @user.team.workspace_id })
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @text_blocks,
          serializer: TextBlockSerializer
        ).to_json
      end

      def create
        @text_block = current_user.profile_block.text_blocks.build(text_block_params)

        if @text_block.save
          render json: @text_block, serializer: TextBlockSerializer
        else
          render json: @text_block.errors, status: :bad_request
        end
      end

      private

      def text_block_params
        params.require(:text_block).permit(:title, :text)
      end
    end
  end
end

