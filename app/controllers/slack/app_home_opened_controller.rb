module Slack
  class AppHomeOpenedController < Slack::ApplicationController
    def respond
      if params[:challenge].present?
        render_challenge
      elsif params[:event][:type] == 'app_home_opened'
        app_home_publish
      else
        Rails.logger.debug 'vacant_app_home_request'
      end
    end

    private

    def render_challenge
      render json: params[:challenge], status: 200
    end

    def app_home_publish
      team = Team.find_by(workspace_id: params[:team_id])
      users = team.users
      access_token = try_set_access_token_from(users)
      client = set_client(access_token)
      return unless client_valid?(client)

      user_id = params[:event][:user]
      view = Slack::BlockKitView.home_tab_view
      client.views_publish(user_id: user_id, view: view)
    end
  end
end
