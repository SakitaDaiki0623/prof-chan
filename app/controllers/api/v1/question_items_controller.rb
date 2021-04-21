# app/controllers/api/v1/question_items_controller.rb
module Api
  module V1
    class QuestionItemsController < ApiController
      before_action :set_question_item, only: %i[update destroy]

      def index
        @user = User.find(current_user.id)
        @question_items = QuestionItem.includes(question_block: { profile_block: { user: :team } } ).where(teams: { workspace_id: @user.team.workspace_id })
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @question_items,
          serializer: QuestionItemSerializer
        ).to_json
      end

      def update
        if @question_item.update(question_item_params)
          render json: @question_item, serializer: QuestionItemSerializer
        else
          render json: @question_item.errors, status: :bad_request
        end
      end

      def destroy
        @question_item.destroy!
        render json: @question_item
      end

      private

      def question_item_params
        params.require(:question_item).permit(:content, :answer)
      end

      def set_question_item
        @question_item = QuestionItem.find(params[:id])
      end
    end
  end
end

