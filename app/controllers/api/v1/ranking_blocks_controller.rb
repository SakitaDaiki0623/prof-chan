# app/controllers/api/v1/ranking_blocks_controller.rb
module Api
  module V1
    class RankingBlocksController < ApiController
      before_action :set_ranking_block, only: %i[show update destroy]

      def index
        @ranking_blocks = RankingBlock.by_team(current_user)
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @ranking_blocks,
          serializer: RankingBlockSerializer
        ).to_json
      end

      def create
        @ranking_block = current_user.profile_block.ranking_blocks.build(ranking_block_params)

        if @ranking_block.save
          render json: @ranking_block, serializer: RankingBlockSerializer
        else
          render json: @ranking_block.errors, status: :bad_request
        end
      end

      def show; end

      def update
        if @ranking_block.update!(ranking_block_params)
          render json: @ranking_block, serializer: RankingBlockSerializer
        else
          render json: @ranking_block_item_register.errors, status: :bad_request
        end
      end

      def destroy
        @ranking_block.destroy!
        render json: @ranking_block, serializer: RankingBlockSerializer
      end

      private

      def ranking_block_params
        params.require(:ranking_block).permit(:title, :first_place, :second_place, :third_place)
      end

      def set_ranking_block
        @ranking_block = current_user.profile_block.ranking_blocks.find(params[:id])
      end
    end
  end
end
