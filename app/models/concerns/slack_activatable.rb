module SlackActivatable
  def get_channel(user_identity:, hash_token:)
    access_token = Slack::AccessToken.set_access_token(hash_token)
    team = Team.find_by(workspace_id: workspace_id_from(user_identity: user_identity))
    user = User.find_by(uid: uid_from(user_identity: user_identity))
    channel_id = team.share_channel_id if team.present?
    channels = Slack::ApiMethod.conversations_list(access_token)
    channel = get_same_id_channel(channels: channels, channel_id: channel_id)
    return channel if check_all_presence(team, user, channel)

    channel = get_channel_by_either_method(user_identity: user_identity, channels: channels, access_token: access_token, channel: channel, user: user)
    channel
  end

  def check_all_presence(*args)
    expected_result = true
    args.each do |arg|
      if arg.blank?
        expected_result = false
        break
      end
    end

    expected_result
  end

  # user identitiyのdigメソッド
  def workspace_id_from(user_identity:)
    user_identity.dig('team', 'id')
  end

  def uid_from(user_identity:)
    user_identity.dig('user', 'id')
  end

  def user_name_from(user_identity:)
    user_identity.dig('user', 'name')
  end

  def user_image_from(user_identity:)
    user_identity.dig('user', 'image_192')
  end

  def team_from(user_identity:)
    user_identity.dig('team')
  end

  # channel関係

  def get_general_channel(channels)
    channel = channels.select { |channel| is_channel_general?(channel) }[0]
    channel
  end

  def is_channel_general?(channel)
    channel.dig('is_general')
  end

  def get_same_id_channel(channels:, channel_id:)
    channel = channels.select { |channel| channel_id(channel) == channel_id }[0]
    channel
  end

  def channel_id(channel)
    channel.dig('id')
  end

  def get_same_name_channel(channels:, channel_name:)
    channel = channels.select { |channel| channel_name(channel) == channel_name }[0]
    channel
  end

  def channel_name(channel)
    channel.dig('name')
  end

  def channel_from_api_result(result)
    result.dig('channel')
  end

  # =========================

  def get_channel_by_either_method(user_identity:, channels:, access_token:, channel:, user:)
    if channel.nil?
      created_channel = create_channel_flow(user_identity: user_identity, channels: channels, access_token: access_token, general_channel: get_general_channel(channels))
      created_channel
    else
      invite_user_flow(user_identity: user_identity, channel: channel, access_token: access_token)
      channel
    end
  end

  def create_channel_flow(user_identity:, channels:, access_token:, general_channel:)
    created_channel = create_channel_in_workspace(channels: channels, access_token: access_token)
    try_invite_user(user_identity: user_identity, channel: created_channel, access_token: access_token)
    post_app_installed_message_to_general(access_token: access_token, general_channel: general_channel)
    post_messages(user_identity: user_identity, channel: created_channel, access_token: access_token)
    created_channel
  end

  def try_invite_user(user_identity:, channel:, access_token:)
    Slack::ApiMethod.conversations_join(access_token: access_token, channel_id: channel_id(channel))
    Slack::ApiMethod.conversations_invite(access_token: access_token, channel_id: channel_id(channel), user_id: uid_from(user_identity: user_identity))
  end

  def invite_user_flow(user_identity:, channel:, access_token:)
    try_invite_user(user_identity: user_identity, channel: channel, access_token: access_token)
    post_messages(user_identity: user_identity, channel: channel, access_token: access_token)
  end

  def post_messages(user_identity:, channel:, access_token:)
    post_welcome_message_to_channel(user_identity: user_identity, channel: channel, access_token: access_token)
    post_direct_message_to_user(user_identity: user_identity, channel: channel, access_token: access_token)
  end

  def create_channel_in_workspace(channels:, access_token:)
    channel = get_same_name_channel(channels: channels, channel_name: share_channel_name)
    result = if channel.nil?
               Slack::ApiMethod.conversations_create(access_token: access_token, encoded_channel_name: encode_string(share_channel_name))
             else
               Slack::ApiMethod.conversations_info(access_token: access_token, channel_id: channel_id(channel))
             end
    channel_from_api_result(result)
  end

  def encode_string(string)
    URI.encode_www_form_component(string)
  end

  def share_channel_name
    'プロフちゃんスペース'
  end

  def post_welcome_message_to_channel(user_identity:, channel:, access_token:)
    encoded_msg = Slack::BlockKitMessage.welcome_msg(user_identity)
    text = "<@#{uid_from(user_identity: user_identity)}>さんがプロフちゃんを始めました！:hamster:"
    Slack::ApiMethod.chat_post_message(access_token: access_token, channel_id: channel_id(channel), encoded_msg: encoded_msg, encoded_text: encode_string(text))
  end

  def post_direct_message_to_user(user_identity:, channel:, access_token:)
    encoded_msg = Slack::BlockKitMessage.direct_msg_when_installed(user_identity, channel)
    text = 'プロフちゃんの世界へようこそ:hamster:'
    Slack::ApiMethod.chat_post_message(access_token: access_token, channel_id: uid_from(user_identity: user_identity), encoded_msg: encoded_msg, encoded_text: encode_string(text))
  end

  def post_app_installed_message_to_general(access_token:, general_channel:)
    Slack::ApiMethod.conversations_join(access_token: access_token, channel_id: channel_id(general_channel))
    text = 'プロフちゃんがインストールされました:hamster:'
    encoded_msg = Slack::BlockKitMessage.app_installed_msg
    Slack::ApiMethod.chat_post_message(access_token: access_token, channel_id: channel_id(general_channel), encoded_msg: encoded_msg, encoded_text: encode_string(text))
  end
end
