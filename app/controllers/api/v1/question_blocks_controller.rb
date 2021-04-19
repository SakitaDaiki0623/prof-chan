# app/controllers/api/v1/question_blocks_controller.rb
module Api
  module V1
    class QuestionBlocksController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_question_block, only: %i[show update destroy]

      def index
        @user = User.find(current_user.id)
        @question_blocks = QuestionBlock.includes(profile_block: { user: :team }).where(teams: { workspace_id: @user.team.workspace_id })
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

      def show; end

      def update; end

      def destroy
        @question_block.destroy!
        render json: @question_block
      end

      private

      def set_params
        params.permit(
          :question_title, :question_item_content1,
          :question_item_answer1, :question_item_content2, :question_item_answer2, :question_item_content3,
          :question_item_answer3, :current_user).merge(profile_block_id: ProfileBlock.find_by(user_id: User.find(current_user.id)).id)
      end

      def set_question_block
        @question_block = QuestionBlock.find(params[:id])
      end
    end
  end
end
