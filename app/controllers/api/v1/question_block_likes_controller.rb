# app/controllers/api/v1/question_block_likes_controller.rb
module Api
  module V1
    class QuestionBlockLikesController < ApiController
      def index
        @question_block_likes = QuestionBlockLike.filter_by_question_block(params[:question_block_id]).select(:id, :user_id, :question_block_id)
        render json: @question_block_likes
      end

      def create
        current_user.question_block_likes.create!(question_blocks_params)
        head :created
      end

      def destroy
        current_user.question_block_likes.find(params[:id]).destroy!
        head :ok
      end

      private

      def question_blocks_params
        params.require(:question_block_like).permit(:question_block_id)
      end
    end
  end
end
