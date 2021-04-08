module Api
  module V1
    class TeamsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def show
        @user = User.find(current_user.id)
        @team = Team.includes(:users).where(workspace_id: @user.team.workspace_id)
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @team,
          serializer: TeamSerializer
        ).to_json
      end
    end
  end
end
