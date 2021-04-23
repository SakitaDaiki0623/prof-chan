# app/controllers/api/v1/ranking_items_controller.rb
module Api
  module V1
    class RankingItemsController < ApiController
      before_action :set_ranking_item, only: %i[update destroy]

      def index
        @user = User.find(current_user.id)
        @ranking_items = RankingItem.includes(ranking_block: { profile_block: { user: :team } } ).where(teams: { workspace_id: @user.team.workspace_id })
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @ranking_items,
          serializer: RankingItemSerializer
        ).to_json
      end

      def update
        if @ranking_item.update(ranking_item_params)
          render json: @ranking_item, serializer: RankingItemSerializer
        else
          render json: @ranking_item.errors, status: :bad_request
        end
      end

      def create
        @questioin_item = rankingItem.new(ranking_item_params)

        if @questioin_item.save!
          render json: @questioin_item, serializer: RankingItemSerializer
        else
          render json: @questioin_item.errors, status: :bad_request
        end
      end

      def destroy
        @ranking_item.destroy!
        render json: @ranking_item
      end

      private

      def ranking_item_params
        params.require(:ranking_item).permit(:content, :answer, :ranking_block_id)
      end

      def set_ranking_item
        @ranking_item = RankingItem.find(params[:id])
      end
    end
  end
end

