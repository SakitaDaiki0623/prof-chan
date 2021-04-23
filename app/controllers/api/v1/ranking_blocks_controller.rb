# app/controllers/api/v1/ranking_blocks_controller.rb
module Api
  module V1
    class RankingBlocksController < ApiController
      before_action :set_ranking_block, only: %i[show update destroy]

      def index
        @user = User.find(current_user.id)
        @ranking_blocks = RankingBlock.includes(profile_block: { user: :team }).where(teams: { workspace_id: @user.team.workspace_id })
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @ranking_blocks,
          serializer: RankingBlockSerializer
        ).to_json
      end

      def create
        @ranking_block_item_register = RankingBlockItemRegister.new(set_params)
        if @ranking_block_item_register.save
          # TODO: Refactoring RankingBlock.lastでは確実に作成した値を返すかわからない
          @ranking_block = RankingBlock.last
          render json: @ranking_block
        else
          render json: @ranking_block_item_register.errors, status: :bad_request
        end
      end

      def show; end

      def update
        if @ranking_block.update!(ranking_block_params)
          render json: @ranking_block
        else
          render json: @ranking_block_item_register.errors, status: :bad_request
        end
      end

      def destroy
        @ranking_block.destroy!
        render json: @ranking_block
      end

      private

      def set_params
        params.permit(
          :ranking_title, :ranking_item_content1,
          :ranking_item_answer1, :ranking_item_content2, :ranking_item_answer2, :ranking_item_content3,
          :ranking_item_answer3, :current_user).merge(profile_block_id: ProfileBlock.find_by(user_id: User.find(current_user.id)).id)
      end

      def ranking_block_params
        params.require(:ranking_block).permit(:title)
      end

      def set_ranking_block
        @ranking_block = current_user.profile_block.ranking_blocks.find(params[:id])
      end
    end
  end
end
