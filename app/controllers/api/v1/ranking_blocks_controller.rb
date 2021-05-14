# app/controllers/api/v1/ranking_blocks_controller.rb
module Api
  module V1
    class RankingBlocksController < ApiController
      before_action :set_ranking_block, only: %i[show update destroy]

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

      def show; end

      def update
        if @ranking_block.update!(ranking_block_params)
          render json: @ranking_block, serializer: RankingBlockSerializer
        else
          render json: @ranking_block_item_register.errors, status: :bad_request
        end
      end

      def destroy
        @ranking_block.destroy!
        render json: @ranking_block, serializer: RankingBlockSerializer
      end

      def post_to_slack_after_create
        @ranking_block = current_user.profile_block.ranking_blocks.build(ranking_block_params)
        if @ranking_block.valid?
          chat_post_message(@ranking_block)
          render json: @ranking_block, status: :no_content

        else
          render json: @ranking_block.errors, status: :bad_request
        end
      end

      def chat_post_message(block)
        client = Slack::Web::Client.new
        text = "*#{current_user.name}さんがランキングブロックを作成したよ:bangbang:*\n タイトル: :star2:*#{block.title}* :star2:"
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
                "text": ":first_place_medal: *#{block.first_place}*\n- - - - - - - - - - - - - - - - - - - - - -\n:second_place_medal: *#{block.second_place}*\n- - - - - - - - - - - - - - - - - - - - - -\n:third_place_medal: *#{block.third_place}*"
              }
            },
            {
              "type": 'divider'
            }
          ]
        )
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
