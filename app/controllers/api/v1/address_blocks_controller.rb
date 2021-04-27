module Api
  module V1
    class AddressBlocksController < ApiController
      before_action :set_address_block, only: %i[update]

      def index
        @address_blocks = AddressBlock.by_team(current_user)
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @address_blocks,
          serializer: AddressBlockSerializer
        ).to_json
      end

      def update
        
        binding.pry
        
        if @address_block.update!(address_block_params)
          render json: @address_block
        else
          render json: @address_block.errors, status: :bad_request
        end
      end

      private

      def address_block_params
        params.require(:address_block).permit(:instagram, :full_address, :postcode, :twitter)
      end

      def set_address_block
        @address_block = current_user.profile_block.address_block
      end
    end
  end
end
