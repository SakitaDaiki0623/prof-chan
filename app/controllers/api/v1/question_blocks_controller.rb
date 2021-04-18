module Api
  module V1
    class QuestionBlocksController < ApplicationController
      def index; end

      def create
        @question_block = QuestionBlockItem.new(format_params)

        if @question_block.save
          render json: @question_block
        else
          render json: @question_block.errors, status: :bad_request
        end
      end

      def show; end

      def update; end

      def destroy; end

      private

      def format_params
        params.require(:question_block_item).permit(:title, :content, :answer)
      end
    end
  end
end
