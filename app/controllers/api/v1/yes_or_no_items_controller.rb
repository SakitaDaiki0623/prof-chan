# app/controllers/api/v1/yes_or_no_items_controller.rb
module Api
  module V1
    class YesOrNoItemsController < ApiController
      before_action :set_yes_or_no_item, only: %i[update destroy]

      def index
        @yes_or_no_items = YesOrNoItem.by_team_block(current_user)
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @yes_or_no_items,
          serializer: YesOrNoItemSerializer
        ).to_json
      end

      def update
        if @yes_or_no_item.update(yes_or_no_item_params)
          render json: @yes_or_no_item, serializer: YesOrNoItemSerializer
        else
          render json: @yes_or_no_item.errors, status: :bad_request
        end
      end

      def create
        @questioin_item = YesOrNoItem.new(yes_or_no_item_params)

        if @questioin_item.save!
          render json: @questioin_item, serializer: YesOrNoItemSerializer
        else
          render json: @questioin_item.errors, status: :bad_request
        end
      end

      def destroy
        @yes_or_no_item.destroy!
        render json: @yes_or_no_item
      end

      private

      def yes_or_no_item_params
        params.require(:yes_or_no_item).permit(:content, :answer, :yes_or_no_block_id)
      end

      def set_yes_or_no_item
        @yes_or_no_item = YesOrNoItem.find(params[:id])
      end
    end
  end
end
