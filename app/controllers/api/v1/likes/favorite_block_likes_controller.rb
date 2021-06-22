module Api
  module V1
    module Likes
      class FavoriteBlockLikesController < ApiController
        def index
          @favorite_block_likes = FavoriteBlockLike.filter_by_favorite_block(params[:favorite_block_id]).select(:id, :user_id, :favorite_block_id)
          render json: @favorite_block_likes
        end

        def create
          current_user.favorite_block_likes.create!(favorite_blocks_params)
          head :created
        end

        def destroy
          current_user.favorite_block_likes.find(params[:id]).destroy!
          head :ok
        end

        private

        def favorite_blocks_params
          params.require(:favorite_block_like).permit(:favorite_block_id)
        end
      end
    end
  end
end
