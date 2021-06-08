# app/controllers/api/v1/favorite_blocks_controller.rb
module Api
  module V1

    class FavoriteBlocksController < ApiController
      before_action :set_favorite_block, only: %i[show update destroy]

      def index
        @favorite_blocks = FavoriteBlock.by_team(current_user)
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @favorite_blocks,
          serializer: FavoriteBlockSerializer
        ).to_json
      end

      def create
        @favorite_block = current_user.profile_block.favorite_blocks.build(favorite_block_params)

        if @favorite_block.save
          render json: @favorite_block, serializer: FavoriteBlockSerializer
        else
          render json: @favorite_block.errors, status: :bad_request
        end
      end

      def update
        authorize @favorite_block
        if @favorite_block.update(favorite_block_params)
          render json: @favorite_block, serializer: FavoriteBlockSerializer
        else
          render json: @favorite_block.errors, status: :bad_request
        end
      end

      def show; end

      def destroy
        authorize @favorite_block, :update?
        @favorite_block.destroy!
        render json: @favorite_block
      end

      def popular_blocks
        @favorite_popular_blocks = FavoriteBlock.by_team(current_user).popular_blocks

        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @favorite_popular_blocks,
          serializer: FavoriteBlockSerializer
        ).to_json
      end

      def random_current_user_likes_blocks
        @favorite_blocks = []
        @random_current_user_likes = FavoriteBlockLike.filter_by_current_user(current_user.id)
        @random_current_user_likes.each do |like|
          @favorite_blocks << FavoriteBlock.find(like.favorite_block_id)
        end
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @favorite_blocks,
          serializer: FavoriteBlockSerializer
        ).to_json
      end

      def current_user_having
        @favorite_blocks = current_user.profile_block.favorite_blocks
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @favorite_blocks,
          serializer: FavoriteBlockSerializer
        ).to_json
      end

      private

      def favorite_block_params
        params.require(:favorite_block).permit(:text, :category_id)
      end

      def set_favorite_block
        @favorite_block = FavoriteBlock.find(params[:id])
      end
    end
  end
end