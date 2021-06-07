# app/controllers/api/v1/question_blocks_controller.rb
module Api
  module V1
    class QuestionBlocksController < ApiController
      before_action :set_question_block, only: %i[update destroy]
      include PostMessageModule

      def index
        @question_blocks = QuestionBlock.by_team(current_user)
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @question_blocks,
          serializer: QuestionBlockSerializer
        ).to_json
      end

      def create
        @question_block_item_register = QuestionBlockItemRegister.new(set_params)
        if @question_block_item_register.save
          @question_block = current_user.profile_block.question_blocks.last
          render json: @question_block
        else
          render json: @question_block_item_register.errors, status: :bad_request
        end
      end

      def update
        authorize @question_block
        if @question_block.update!(question_block_params)
          render json: @question_block
        else
          render json: @question_block_item_register.errors, status: :bad_request
        end
      end

      def destroy
        authorize @question_block, :update?
        @question_block.destroy!
        render json: @question_block
      end

      def popular_blocks
        @question_popular_blocks = QuestionBlock.by_team(current_user).popular_blocks
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @question_popular_blocks,
          serializer: QuestionBlockSerializer
        ).to_json
      end

      def random_current_user_likes_blocks
        question_blocks = []
        @random_current_user_likes = QuestionBlockLike.filter_by_current_user(current_user.id)
        @random_current_user_likes.each do |like|
          question_blocks << QuestionBlock.find(like.question_block_id)
        end
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          question_blocks,
          serializer: QuestionBlockSerializer
        ).to_json
      end

      def post_to_slack_after_create
        @question_block_item_register = QuestionBlockItemRegister.new(set_params)
        if @question_block_item_register.valid?
          post_questioin_block(@question_block_item_register)
          render json: @question_block_item_register, status: :no_content

        else
          render json: @question_block_item_register.errors, status: :bad_request
        end
      end

      private

      def set_params
        params.permit(
          :question_title, :question_item_content1,
          :question_item_answer1, :question_item_content2, :question_item_answer2, :question_item_content3,
          :question_item_answer3, :current_user
        ).merge(profile_block_id: ProfileBlock.find_by(user_id: User.find(current_user.id)).id)
      end

      def question_block_params
        params.require(:question_block).permit(:title)
      end

      def set_question_block
        @question_block = current_user.profile_block.question_blocks.find(params[:id])
      end
    end
  end
end
