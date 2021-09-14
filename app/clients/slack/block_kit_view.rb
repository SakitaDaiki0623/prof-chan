module Slack
  class BlockKitView
    def self.home_tab_view
      view = { "type": 'home', "blocks": [{ "type": 'divider' }, { "type": 'section', "text": { "type": 'mrkdwn', "text": "*投稿機能について*\n --------------------------------------------- \n :eight_spoked_asterisk:  各ブロックの投稿 \n 各ブロックを1日に一度投稿することができるよ:star:\nみんなに共有したいことを投稿してみよう！\n --------------------------------------------- \n:sparkle:  毎日18時の自動投稿 \n毎日18時にチーム内の各ブロックを投稿するよ:star: \n あなたのブロックが選ばれたら嬉しいな！" } }, { "type": 'divider' }, { "type": 'section', "text": { "type": 'mrkdwn', "text": "*Slashコマンドについて*\n本アプリでは以下のコマンドがSlack内で利用できるよ:hamster:" } }, { "type": 'section', "fields": [{ "type": 'mrkdwn', "text": ":information_source: `/prof_help` \nDMでヘルプメッセージを送るよ" }, { "type": 'mrkdwn', "text": ":postbox: `/prof_random_block` \n DMでランダムにブロックを1つ送るよ" }] }, { "type": 'section', "fields": [{ "type": 'mrkdwn', "text": ":ok_hand: `/prof_activate_share` \n毎日18時の投稿を有効するよ" }, { "type": 'mrkdwn', "text": ":raised_back_of_hand: `/prof_deactivate_share` \n 毎日18時の投稿を止めるよ" }] }, { "type": 'divider' }] }.to_json
      view
    end
  end
end
