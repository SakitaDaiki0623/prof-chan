module Api
  module V1
    module Likes
      class TextBlockLikesController < ApiController
        def index
          @text_block_likes = TextBlockLike.filter_by_text_block(params[:text_block_id]).select(:id, :user_id, :text_block_id)
          render json: @text_block_likes
        end

        def create
          current_user.text_block_likes.create!(text_blocks_params)
          head :created
        end

        def destroy
          current_user.text_block_likes.find(params[:id]).destroy!
          head :ok
        end

        private

        def text_blocks_params
          params.require(:text_block_like).permit(:text_block_id)
        end
      end
    end
  end
end
