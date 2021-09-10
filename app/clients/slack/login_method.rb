module Slack
  class LoginMethod
    def self.check_channel(info, hash_token)
      access_token = Slack::AccessToken.set_access_token(hash_token)
      team = Team.find_by(workspace_id: info.dig('team', 'id'))
      channel_id = team.share_channel_id if team.present?
      user = User.find_by(uid: info.dig('user', 'id'))
      channels = Slack::ApiMethod.conversations_list(access_token).dig('channels')
      channel = channels.select { |c| c.dig('id') == channel_id }[0]
      return channel if team.present? && user.present? && channel.present?

      channel = get_channel_by_either_method(info, channels, access_token, channel, user)
      channel
    end

    def self.get_channel_by_either_method(info, channels, access_token, channel, user)
      if channel.nil?
        general_channel = get_general_channel(channels)
        created_channel = create_channel_flow(info, channels, access_token, general_channel)
        created_channel
      elsif user.nil? && channel.present?
        invite_user_flow(info, channel, access_token)
        channel
      end
    end

    def self.get_general_channel(channels)
      channel = channels.select { |c| c.dig('is_general') }[0]
      channel
    end

    def self.create_channel_flow(info, channels, access_token, general_channel)
      created_channel = create_channel_in_team(channels, access_token)
      invite_result = try_invite_user(info, created_channel, access_token)
      if invite_result.dig('ok')
        post_app_installed_message_to_general(access_token, general_channel)
        post_messages(info, created_channel, access_token)
      elsif invite_result.dig('ok') == false && invite_result.dig('error') == 'not_in_channel'
        invite_bot_result = try_invite_bot(created_channel, access_token)
        if invite_bot_result.dig('ok')
          try_invite_user(info, created_channel, access_token)
          post_messages(info, created_channel, access_token)
        end
      end
      created_channel
    end

    def self.invite_user_flow(info, channel, access_token)
      invite_result = try_invite_user(info, channel, access_token)
      if invite_result.dig('ok')
        post_messages(info, channel, access_token)
      elsif invite_result.dig('ok') == false && invite_result.dig('error') == 'not_in_channel'
        invite_bot_result = try_invite_bot(channel, access_token)
        if invite_bot_result.dig('ok')
          try_invite_user(info, channel, access_token)
          post_messages(info, channel, access_token)
        end
      end
      channel
    end

    def self.post_messages(info, channel, access_token)
      post_welcome_message_to_channel(info, channel, access_token)
      post_direct_message_to_user(info, channel, access_token)
    end

    def self.create_channel_in_team(channels, access_token)
      channel_name = 'プロフちゃんスペース'
      channel = channels.select { |c| c.dig('name') == channel_name }[0]
      if channel.nil?
        encoded_channel_name = URI.encode_www_form_component(channel_name)
        create_result = Slack::ApiMethod.conversations_create(access_token, encoded_channel_name)
        create_result.dig('channel')
      else
        channel_id = channel.dig('id')
        info_result = Slack::ApiMethod.conversations_info(access_token, channel_id)
        info_result.dig('channel')
      end
    end

    def self.try_invite_user(info, channel, access_token)
      channel_id = channel.dig('id')
      user_id = info.dig('user', 'id')
      Slack::ApiMethod.conversations_invite(access_token, channel_id, user_id)
    end

    def self.try_invite_bot(channel, access_token)
      channel_id = channel.dig('id')
      Slack::ApiMethod.conversations_join(access_token, channel_id)
    end

    def self.post_welcome_message_to_channel(info, channel, access_token)
      channel_id = channel.dig('id')
      user_id = info.dig('user', 'id')
      encoded_msg = Slack::BlockKitMessage.welcome_msg(info)
      text = "<@#{user_id}>さんがプロフちゃんを始めました！:hamster:"
      encoded_text = URI.encode_www_form_component(text)
      Slack::ApiMethod.chat_post_message(access_token, channel_id, encoded_msg, encoded_text)
    end

    def self.post_direct_message_to_user(info, channel, access_token)
      user_id = info.dig('user', 'id')
      encoded_msg = Slack::BlockKitMessage.direct_msg_when_installed(info, channel)
      text = 'プロフちゃんの世界へようこそ:hamster:'
      encoded_text = URI.encode_www_form_component(text)
      Slack::ApiMethod.chat_post_message(access_token, user_id, encoded_msg, encoded_text)
    end

    def self.post_app_installed_message_to_general(access_token, general_channel)
      try_invite_bot(general_channel, access_token)
      channel_id = general_channel.dig('id')
      text = 'プロフちゃんがインストールされました:hamster:'
      encoded_text = URI.encode_www_form_component(text)
      encoded_msg = Slack::BlockKitMessage.app_installed_msg
      Slack::ApiMethod.chat_post_message(access_token, channel_id, encoded_msg, encoded_text)
    end
  end
end
