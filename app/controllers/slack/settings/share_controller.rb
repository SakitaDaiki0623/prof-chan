module Slack
  module Settings
    class ShareController < Slack::ApplicationController
      before_action :set_user, only: %i[activate deactivate]

      def activate
        if @user.nil?
          send_please_login_msg
        else
          Slack::SlashCommand::ShareRight.activate_share_right(@user)
        end
      end

      def deactivate
        if @user.nil?
          send_please_login_msg
        else
          Slack::SlashCommand::ShareRight.deactivate_share_right(@user)
        end
      end

      private

      def set_user
        @user = User.find_by(uid: params[:user_id])
      end
    end
  end
end
