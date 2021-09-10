module Slack
  class BlockKitMessage
    def self.welcome_msg(info)
      user_id = info.dig('user', 'id')
      user_image = info.dig('user', 'image_192')
      msg = "[ { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '@here \n <@#{user_id}>さんがプロフちゃんを始めました！:hamster:\n プロフを確認して気になる話題を探してみよう！:star: \n 共通の話題があると嬉しいな！' }, 'accessory': { 'type': 'image', 'image_url': '#{user_image}', 'alt_text': 'alt text for image' } }, { 'type': 'divider' } ]"
      ERB::Util.url_encode(msg)
    end

    def self.app_installed_msg
      msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '@here \n Slack App プロフちゃんがインストールされました:hamster:' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*本アプリについて*\n社内で特別な社員プロフィールを共有できるSlackと連携したアプリです:hamster:\n みんなが知らない趣味や特殊な項目を入力してみましょう！\n <https://www.prof-chan.com/|プロフちゃん公式サイト>' } }, { 'type': 'divider' } ]"
      ERB::Util.url_encode(msg)
    end

    def self.direct_msg_when_installed(info, channel)
      team_domain = info.dig('team', 'domain')
      channel_id = channel.dig('id')
      channel_name = channel.dig('name')
      message = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': 'プロフちゃんの世界へようこそ:musical_note:\nこれからよろしくお願いします:hamster:\n' } }, { 'type': 'divider' }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*アプリ専用チャンネルについて* \n チームのプロフは<https://#{team_domain}.slack.com/archives/#{channel_id}/|##{channel_name}>で共有するよ！\n あなたが入力した内容を共有チャンネルでシェアしよう！ \n :warning:<https://#{team_domain}.slack.com/archives/#{channel_id}/|##{channel_name}>から退出するとあなたからの投稿ができなくなります' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*投稿機能について*\n --------------------------------------------- \n :eight_spoked_asterisk:  各ブロックの投稿 \n 各ブロックを1日に一度投稿することができるよ:star:\nみんなに共有したいことを投稿してみよう！\n --------------------------------------------- \n:sparkle:  毎日18時の自動投稿 \n毎日18時にチーム内の各ブロックを投稿するよ:star: \n あなたのブロックが選ばれたら嬉しいな！' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*Slashコマンドについて*\n本アプリでは以下のコマンドがSlack内で利用できるよ:hamster:' } }, { 'type': 'section', 'fields': [ { 'type': 'mrkdwn', 'text': ':information_source: `/prof_help` \nDMでヘルプメッセージを送るよ' }, { 'type': 'mrkdwn', 'text': ':postbox: `/prof_random_block` \n DMでランダムにブロックを1つ送るよ' } ] }, { 'type': 'section', 'fields': [ { 'type': 'mrkdwn', 'text': ':ok_hand: `/prof_activate_share` \n毎日18時の投稿を有効するよ' }, { 'type': 'mrkdwn', 'text': ':raised_back_of_hand: `/prof_deactivate_share` \n 毎日18時の投稿を止めるよ' } ] } ]"
      ERB::Util.url_encode(message)
    end
  end
end
