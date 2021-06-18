module SlackApiActivatable
  def check_channel(info, auth, access_token)
    channels = get_channel_list(access_token).dig('channels')
    channel_name = 'プロフ共有スペース'
    channel = channels.select { |c| c.dig('name') == channel_name }[0]

    return channel if User.find_by(uid: auth.uid).present?

    if channel.nil?
      created_channel = create_channel_in_team(channel_name, access_token).dig('channel')
      invite_result = try_invite_user(info, created_channel, access_token)
      if invite_result.dig('ok')
        post_welcome_message_to_channel(info, created_channel, access_token)
        post_direct_message_to_user(info, created_channel, access_token)
      end
      created_channel
    else
      invite_result = try_invite_user(info, channel, access_token)
      if invite_result.dig('ok')
        post_welcome_message_to_channel(info, channel, access_token)
        post_direct_message_to_user(info, channel, access_token)
      end
      channel
    end
  end

  # API Methods
  def get_user_info(user_token)
    user_token.get('/api/users.identity').parsed
  end

  def get_channel_list(access_token)
    access_token.get('/api/conversations.list?limit=1000&pretty=1').parsed
  end

  def create_channel_in_team(channel_name, access_token)
    encoded_name = URI.encode_www_form_component(channel_name)
    access_token.post("api/conversations.create?name=#{encoded_name}&pretty=1").parsed
  end

  def try_invite_user(info, channel, access_token)
    channel_id = channel.dig('id')
    user_id = info.dig('user', 'id')
    access_token.post("api/conversations.invite?channel=#{channel_id}&users=#{user_id}&pretty=1").parsed
  end

  def post_welcome_message_to_channel(info, channel, access_token)
    channel_id = channel.dig('id')
    user_id = info.dig('user', 'id')
    encoded_mgs = get_block_kit_welcome_msg(info)
    text = "<@#{user_id}>さんがプロフちゃんを始めました！"
    encoded_text = URI.encode_www_form_component(text)
    access_token.post("api/chat.postMessage?channel=#{channel_id}&blocks=#{encoded_mgs}&text=#{encoded_text}&pretty=1").parsed
  end

  def post_direct_message_to_user(info, channel, access_token)
    user_id = info.dig('user', 'id')
    encoded_mgs = get_block_kit_direct_msg(info, channel)
    text = 'プロフちゃんの世界へようこそ'
    encoded_text = URI.encode_www_form_component(text)
    access_token.post("api/chat.postMessage?channel=#{user_id}&blocks=#{encoded_mgs}&text=#{encoded_text}&pretty=1").parsed
  end

  def get_block_kit_welcome_msg(info)
    user_id = info.dig('user', 'id')
    user_image = info.dig('user', 'image_192')
    message = "[ { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '@here \n <@#{user_id}>さんがプロフちゃんを始めました！:hamster:\n プロフを確認して気になる話題を探してみよう！:star: \n 共通の話題があると嬉しいな！' }, 'accessory': { 'type': 'image', 'image_url': '#{user_image}', 'alt_text': 'alt text for image' } }, { 'type': 'divider' } ]"
    ERB::Util.url_encode(message)
  end

  def get_block_kit_direct_msg(info, channel)
    team_domain = info.dig('team', 'domain')
    channel_id = channel.dig('id')
    message = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': 'プロフちゃんの世界へようこそ:musical_note:\nこれからよろしくお願いします:hamster:\n' } }, { 'type': 'divider' }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*アプリ専用チャンネルについて* \n チームのプロフは<https://#{team_domain}.slack.com/archives/#{channel_id}/|#プロフ共有スペース>で共有するよ！\n あなたが入力した内容を共有チャンネルでシェアしよう！ \n :warning:<https://#{team_domain}.slack.com/archives/#{channel_id}/|#プロフ共有スペース>から退出するとあなたからの投稿ができなくなります' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*投稿機能について*\n --------------------------------------------- \n :eight_spoked_asterisk:  各ブロックの投稿 \n 各ブロックを1日に一度投稿することができるよ:star:\nみんなに共有したいことを投稿してみよう！\n --------------------------------------------- \n:sparkle:  毎日18時の自動投稿 \n毎日18時にチーム内の各ブロックを投稿するよ:star: \n あなたのブロックが選ばれたら嬉しいな！' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*Slashコマンドについて*\n本アプリでは以下のコマンドがSlack内で利用できるよ:hamster:' } }, { 'type': 'section', 'fields': [ { 'type': 'mrkdwn', 'text': ':information_source: `/prof_help` \nDMでヘルプメッセージを送るよ' }, { 'type': 'mrkdwn', 'text': ':postbox: `/prof_random_block` \n DMでランダムにブロックを1つ送るよ' } ] }, { 'type': 'section', 'fields': [ { 'type': 'mrkdwn', 'text': ':ok_hand: `/prof_activate_share` \n毎日18時の投稿を有効するよ' }, { 'type': 'mrkdwn', 'text': ':raised_back_of_hand: `/prof_inactivate_share` \n 毎日18時の投稿を止めるよ' } ] } ]"
    ERB::Util.url_encode(message)
  end
end
