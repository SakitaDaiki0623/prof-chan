module Slack
  class ApiMethod
    def self.users_identity(bot_token)
      user_token = bot_token.user_token
      user_token.get('/api/users.identity').parsed
    end

    def self.conversations_list(access_token)
      access_token.get('/api/conversations.list?limit=1000&pretty=1').parsed.dig('channels')
    end

    def self.conversations_create(access_token:, encoded_channel_name:)
      access_token.post("api/conversations.create?name=#{encoded_channel_name}&pretty=1").parsed
    end

    def self.conversations_info(access_token:, channel_id:)
      access_token.post("api/conversations.info?channel=#{channel_id}&pretty=1").parsed
    end

    def self.conversations_invite(access_token:, channel_id:, user_id:)
      access_token.post("api/conversations.invite?channel=#{channel_id}&users=#{user_id}&pretty=1").parsed
    end

    def self.conversations_join(access_token:, channel_id:)
      access_token.post("api/conversations.join?channel=#{channel_id}&pretty=1").parsed
    end

    def self.chat_post_message(access_token:, channel_id:, encoded_msg:, encoded_text:)
      access_token.post("api/chat.postMessage?channel=#{channel_id}&blocks=#{encoded_msg}&text=#{encoded_text}&pretty=1").parsed
    end
  end
end
