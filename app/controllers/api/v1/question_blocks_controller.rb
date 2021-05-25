# app/controllers/api/v1/question_blocks_controller.rb
module Api
  module V1
    class QuestionBlocksController < ApiController
      before_action :set_question_block, only: %i[update destroy]

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
          # TODO: Refactoring QuestionBlock.lastでは確実に作成した値を返すかわからない
          @question_block = QuestionBlock.last
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
          chat_post_message(@question_block_item_register)
          render json: @question_block_item_register, status: :no_content

        else
          render json: @question_block_item_register.errors, status: :bad_request
        end
      end

      def chat_post_message(register)
        client = Slack::Web::Client.new
        post_text = if register.question_item_content3.present? && register.question_item_answer3.present?
                      " #{register.question_item_content1}\n :arrow_right:* #{register.question_item_answer1}:*:\n #{register.question_item_content2}\n :arrow_right:* #{register.question_item_answer2}:*\n#{register.question_item_content3}\n :arrow_right:* #{register.question_item_answer3}:*\n"
                    elsif register.question_item_content2.present? && register.question_item_answer2.present?
                      " #{register.question_item_content1}\n :arrow_right:* #{register.question_item_answer1}:*\n #{register.question_item_content2}\n :arrow_right:* #{register.question_item_answer2}:*"
                    else
                      " #{register.question_item_content1}\n :arrow_right:* #{register.question_item_answer1}:*"
                    end

        text = "*#{current_user.name}さんがクエスチョンブロックを作成したよ:bangbang:*\n タイトル: :star2:*#{register.question_title}* :star2:"

        client.chat_postMessage(
          channel: '#プロフちゃん実験',
          text: text,
          blocks: [
            {
              "type": 'section',
              "text": {
                "type": 'mrkdwn',
                "text": text
              }
            },
            {
              "type": 'divider'
            },
            {
              "type": 'section',
              "text": {
                "type": 'mrkdwn',
                "text": post_text
              },
              "accessory": {
                "type": 'image',
                "image_url": current_user.image.to_s,
                "alt_text": 'computer thumbnail'
              }
            },
            {
              "type": 'divider'
            }
          ]
        )
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
