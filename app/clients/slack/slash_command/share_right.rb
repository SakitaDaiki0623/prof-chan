module Slack
  module SlashCommand
    class ShareRight
      def self.activate_share_right(user)
        access_token = Slack::AccessToken.make_access_token(user.authentication.access_token)
        if user.team.share_right_inactive?
          user.team.share_right_active!
          post_activate_msg_to_workspace(access_token: access_token, user: user)
        else
          post_already_activated_msg_to_user(access_token: access_token, user: user)
        end
      end

      def self.post_activate_msg_to_workspace(access_token:, user:)
        channel_id = user.team.share_channel_id
        text = "<#{user.name}>が毎日18時の投稿をONにしたよ:hamster:"
        encoded_msg = Slack::BlockKitMessage.activate_msg(user)
        Slack::ApiMethod.chat_post_message(access_token: access_token, channel_id: channel_id, encoded_msg: encoded_msg, encoded_text: ERB::Util.url_encode(text))
      end

      def self.post_already_activated_msg_to_user(access_token:, user:)
        channel_id = user.uid
        text = '既に18時の投稿はONだよ:hamster:'
        encoded_msg = Slack::BlockKitMessage.already_activated_msg(user)
        Slack::ApiMethod.chat_post_message(access_token: access_token, channel_id: channel_id, encoded_msg: encoded_msg, encoded_text: ERB::Util.url_encode(text))
      end

      def self.deactivate_share_right(user)
        access_token = Slack::AccessToken.make_access_token(user.authentication.access_token)
        if user.team.share_right_active?
          user.team.share_right_inactive!
          post_deactivate_msg_to_workspace(access_token: access_token, user: user)
        else
          post_already_deactivated_msg_to_user(access_token: access_token, user: user)
        end
      end

      def self.post_deactivate_msg_to_workspace(access_token:, user:)
        channel_id = user.team.share_channel_id
        text = "<#{user.name}>が毎日18時の投稿をOFFにしたよ:hamster:"
        encoded_msg = Slack::BlockKitMessage.deactivate_msg(user)
        Slack::ApiMethod.chat_post_message(access_token: access_token, channel_id: channel_id, encoded_msg: encoded_msg, encoded_text: ERB::Util.url_encode(text))
      end

      def self.post_already_deactivated_msg_to_user(access_token:, user:)
        channel_id = user.uid
        text = '既に18時の投稿はOFFだよ:hamster:'
        encoded_msg = Slack::BlockKitMessage.already_activated_msg(user)
        Slack::ApiMethod.chat_post_message(access_token: access_token, channel_id: channel_id, encoded_msg: encoded_msg, encoded_text: ERB::Util.url_encode(text))
      end
    end
  end
end
