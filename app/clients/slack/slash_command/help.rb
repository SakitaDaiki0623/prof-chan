module Slack
  module SlashCommand
    class Help
      def self.post_help_msg(user)
        access_token = Slack::AccessToken.make_access_token(user.authentication.access_token)
        text = 'ヘルプメッセージを送信しました:hamster:'
        encoded_msg = Slack::BlockKitMessage.help_msg
        Slack::ApiMethod.chat_post_message(access_token: access_token, channel_id: user.uid, encoded_msg: encoded_msg, encoded_text: ERB::Util.url_encode(text))
      end
    end
  end
end
