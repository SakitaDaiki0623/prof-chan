# app/controllers/api/v1/text_blocks_controller.rb
module Api
  module V1
    class TextBlocksController < ApiController
      before_action :set_text_block, only: %i[show update destroy]

      def index
        @text_blocks = TextBlock.by_team(current_user)
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @text_blocks,
          serializer: TextBlockSerializer
        ).to_json
      end

      def create
        @text_block = current_user.profile_block.text_blocks.build(text_block_params)

        if @text_block.save
          render json: @text_block, serializer: TextBlockSerializer
        else
          render json: @text_block.errors, status: :bad_request
        end
      end

      def update
        if @text_block.update(text_block_params)
          render json: @text_block, serializer: TextBlockSerializer
        else
          render json: @text_block.errors, status: :bad_request
        end
      end

      def show; end

      def destroy
        @text_block.destroy!
        render json: @text_block
      end

      def popular_blocks
        @text_popular_blocks = TextBlock.by_team(current_user).popular_blocks
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @text_popular_blocks,
          serializer: TextBlockSerializer
        ).to_json
      end

      def post_to_slack_after_create
        @text_block = current_user.profile_block.text_blocks.build(text_block_params)
        if @text_block.valid?
          chat_post_message(@text_block)
          render json: @text_block, status: :no_content

        else
          render json: @text_block.errors, status: :bad_request
        end
      end

      def chat_post_message(block)
        client = Slack::Web::Client.new
        text = "#{current_user.name}さんがテキストブロックを作成したよ:bangbang:*\n タイトル: :star2:*#{block.title}* :star2:"
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
                "text": block.text
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

      def text_block_params
        params.require(:text_block).permit(:title, :text)
      end

      def set_text_block
        @text_block = TextBlock.find(params[:id])
      end
    end
  end
end
