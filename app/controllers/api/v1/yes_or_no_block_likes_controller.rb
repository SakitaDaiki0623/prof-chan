module Api
  module V1
    class YesOrNoBlockLikesController < ApiController
      def index
        @yes_or_no_block_likes = YesOrNoBlockLike.filter_by_yes_or_no_block(params[:yes_or_no_block_id]).select(:id, :user_id, :yes_or_no_block_id)
        render json: @yes_or_no_block_likes
      end

      def create
        current_user.yes_or_no_block_likes.create!(yes_or_no_blocks_params)
        head :created
      end

      def destroy
        current_user.yes_or_no_block_likes.find(params[:id]).destroy!
        head :ok
      end

      private

      def yes_or_no_blocks_params
        params.require(:yes_or_no_block_like).permit(:yes_or_no_block_id)
      end
    end
  end
end
