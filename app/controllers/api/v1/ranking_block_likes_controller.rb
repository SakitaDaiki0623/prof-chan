module Api
  module V1
    class RankingBlockLikesController < ApiController
      def index
        @ranking_block_likes = RankingBlockLike.filter_by_ranking_block(params[:ranking_block_id]).select(:id, :user_id, :ranking_block_id)
        render json: @ranking_block_likes
      end

      def create
        current_user.ranking_block_likes.create!(ranking_blocks_params)
        head :created
      end

      def destroy
        current_user.ranking_block_likes.find(params[:id]).destroy!
        head :ok
      end

      private

      def ranking_blocks_params
        params.require(:ranking_block_like).permit(:ranking_block_id)
      end
    end
  end
end
