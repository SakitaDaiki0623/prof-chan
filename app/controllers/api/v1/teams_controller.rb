module Api
  module V1
    class TeamsController < ApiController
      before_action :set_team, only: %i[show]

      def show
        render json: @team
      end

      private

      def set_team
        @team = Team.find_by!(workspace_id: params[:id])
      end
    end
  end
end
