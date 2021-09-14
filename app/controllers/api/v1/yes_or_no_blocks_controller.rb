module Api
  module V1
    class YesOrNoBlocksController < ApiController
      before_action :set_yes_or_no_block, only: %i[update destroy]

      def index
        @yes_or_no_blocks = YesOrNoBlock.by_team(current_user)
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @yes_or_no_blocks,
          serializer: YesOrNoBlockSerializer
        ).to_json
      end

      def create
        @yes_or_no_block_item_register = YesOrNoBlockItemRegister.new(set_params)
        if @yes_or_no_block_item_register.save_block_and_items
          @yes_or_no_block = current_user.profile_block.yes_or_no_blocks.last
          render json: @yes_or_no_block
        else
          render json: @yes_or_no_block_item_register.errors, status: :bad_request
        end
      end

      def update
        authorize @yes_or_no_block
        if @yes_or_no_block.update!(yes_or_no_block_params)
          render json: @yes_or_no_block
        else
          render json: @yes_or_no_block.errors, status: :bad_request
        end
      end

      def destroy
        authorize @yes_or_no_block, :update?
        @yes_or_no_block.destroy!
        render json: @yes_or_no_block
      end

      def popular_blocks
        @yes_or_no_popular_blocks = YesOrNoBlock.by_team(current_user).includes([:users]).popular_blocks
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @yes_or_no_popular_blocks,
          serializer: YesOrNoBlockSerializer
        ).to_json
      end

      def random_current_user_likes_blocks
        @yes_or_no_blocks = []
        @random_current_user_likes = YesOrNoBlockLike.filter_by_current_user(current_user.id)
        @random_current_user_likes.each do |like|
          @yes_or_no_blocks << YesOrNoBlock.find(like.yes_or_no_block_id)
        end
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @yes_or_no_blocks,
          serializer: YesOrNoBlockSerializer
        ).to_json
      end

      def post_to_slack_after_create
        @yes_or_no_block_item_register = YesOrNoBlockItemRegister.new(set_params)
        if @yes_or_no_block_item_register.valid?
          post_yes_or_no_block(@yes_or_no_block_item_register)
          render json: @yes_or_no_block_item_register, status: :no_content

        else
          render json: @yes_or_no_block_item_register.errors, status: :bad_request
        end
      end

      def recommended_topic_block
        @yes_or_no_block = current_user.profile_block.yes_or_no_blocks.includes(%i[yes_or_no_block_likes users]).popular_blocks[0]
        return if @yes_or_no_block.nil? || @yes_or_no_block.users.blank?

        render json: @yes_or_no_block
      end

      private

      def set_params
        params.permit(
          :yes_or_no_title, :yes_or_no_item_content1,
          :yes_or_no_item_answer1, :yes_or_no_item_content2, :yes_or_no_item_answer2, :yes_or_no_item_content3,
          :yes_or_no_item_answer3, :current_user
        ).merge(profile_block_id: ProfileBlock.find_by(user_id: User.find(current_user.id)).id)
      end

      def yes_or_no_block_params
        params.require(:yes_or_no_block).permit(:title)
      end

      def set_yes_or_no_block
        @yes_or_no_block = current_user.profile_block.yes_or_no_blocks.find(params[:id])
      end
    end
  end
end
