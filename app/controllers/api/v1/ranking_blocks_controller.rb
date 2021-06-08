# app/controllers/api/v1/ranking_blocks_controller.rb
module Api
  module V1
    class RankingBlocksController < ApiController
      before_action :set_ranking_block, only: %i[update destroy]
      include PostMessageModule

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

      def update
        authorize @ranking_block
        if @ranking_block.update!(ranking_block_params)
          render json: @ranking_block, serializer: RankingBlockSerializer
        else
          render json: @ranking_block_item_register.errors, status: :bad_request
        end
      end

      def destroy
        authorize @ranking_block, :update?
        @ranking_block.destroy!
        render json: @ranking_block, serializer: RankingBlockSerializer
      end

      def popular_blocks
        @ranking_popular_blocks = RankingBlock.by_team(current_user).popular_blocks
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @ranking_popular_blocks,
          serializer: RankingBlockSerializer
        ).to_json
      end

      def random_current_user_likes_blocks
        @ranking_blocks = []
        @random_current_user_likes = RankingBlockLike.filter_by_current_user(current_user.id)
        @random_current_user_likes.each do |like|
          @ranking_blocks << RankingBlock.find(like.ranking_block_id)
        end
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @ranking_blocks,
          serializer: RankingBlockSerializer
        ).to_json
      end

      def current_user_having
        @ranking_blocks = current_user.profile_block.ranking_blocks
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @ranking_blocks,
          serializer: RankingBlockSerializer
        ).to_json
      end

      def post_to_slack_after_create
        @ranking_block = current_user.profile_block.ranking_blocks.build(ranking_block_params)
        if @ranking_block.valid?
          post_ranking_block(@ranking_block)
          render json: @ranking_block, status: :no_content
        else
          render json: @ranking_block.errors, status: :bad_request
        end
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
