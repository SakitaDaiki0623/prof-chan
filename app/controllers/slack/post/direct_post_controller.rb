module Slack
  module Post
    class DirectPostController < Slack::ApplicationController
      before_action :set_user, only: %i[help random_block]

      def help
        if @user.nil?
          send_please_login_msg
        else
          Slack::SlashCommand::Help.post_help_msg(@user)
        end
      end

      def random_block
        if @user.nil?
          send_please_login_msg
        else
          Slack::SlashCommand::RandomBlock.post_random_block(@user)
        end
      end

      private

      def set_user
        @user = User.find_by(uid: params[:user_id])
      end
    end
  end
end
