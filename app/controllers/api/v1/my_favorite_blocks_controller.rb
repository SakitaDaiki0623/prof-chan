module Api
  module V1
    class MyFavoriteBlocksController < ApiController
      before_action :set_my_favorite_block, only: %i[update]

      def index
        @my_favorite_blocks = MyFavoriteBlock.by_team(current_user)
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @my_favorite_blocks,
          serializer: MyFavoriteBlockSerializer
        ).to_json
      end

      def update
        if @my_favorite_block.update!(my_favorite_block_params)
          render json: @my_favorite_block
        else
          render json: @my_favorite_block.errors, status: :bad_request
        end
      end

      private

      def my_favorite_block_params
        params.require(:my_favorite_block).permit(:manga_anime, :game_app, :character, :actor, :entertainer, :music, :food, :animal, :sports, :book, :place, :snack, :alcohol_drink, :restaurants, :youtuber, :musician)
      end

      def set_my_favorite_block
        @my_favorite_block = current_user.profile_block.my_favorite_block
      end
    end
  end
end
