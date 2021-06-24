module Slack
  class AppHomeOpenedController < Slack::ApplicationController
    before_action :set_user_team_token, only: %i[publish]

    def respond
      # render json: params[:challenge], status: 200
      if params[:event][:type] == 'app_home_opened'
        views_publish
      elsif params[:event][:type] == 'message' && params[:event][:text].present?
        send_help_msg
      end
    end

    def views_publish
      team = Team.find_by(workspace_id: params[:team_id])
      user = User.find_by(uid: params[:event][:user])
      return if team.nil? || user.nil? || team.workspace_id != user.team.workspace_id

      access_token = set_access_token(user.authentication.access_token)
      publish_to_home_tab(team, user, access_token)
    end

    def publish_to_home_tab(team, user, access_token)
      encoded_msg = encoded_home_tab_block_msg(team)
      res = access_token.post("api/views.publish?user_id=#{user.uid}&view=#{encoded_msg}&pretty=1").parsed
    end

    def encoded_home_tab_block_msg(team)
      channel_id = team.share_channel_id
      channel_name = team.share_channel_name
      msg = "{ 'type': 'home', 'blocks': [ { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*アプリ専用チャンネルについて* \n チームのプロフは<https://#{team.domain}.slack.com/archives/#{channel_id}/|##{channel_name}>で共有するよ！\n あなたが入力した内容を共有チャンネルでシェアしよう！ \n :warning:<https://#{team.domain}.slack.com/archives/#{channel_id}/|##{channel_name}>から退出するとあなたからの投稿ができなくなります' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*投稿機能について*\n --------------------------------------------- \n :eight_spoked_asterisk:  各ブロックの投稿 \n 各ブロックを1日に一度投稿することができるよ:star:\nみんなに共有したいことを投稿してみよう！\n --------------------------------------------- \n:sparkle:  毎日18時の自動投稿 \n毎日18時にチーム内の各ブロックを投稿するよ:star: \n あなたのブロックが選ばれたら嬉しいな！' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '*Slashコマンドについて*\n本アプリでは以下のコマンドがSlack内で利用できるよ:hamster:' } }, { 'type': 'section', 'fields': [ { 'type': 'mrkdwn', 'text': ':information_source: `/prof_help` \nDMでヘルプメッセージを送るよ' }, { 'type': 'mrkdwn', 'text': ':postbox: `/prof_random_block` \n DMでランダムにブロックを1つ送るよ' } ] }, { 'type': 'section', 'fields': [ { 'type': 'mrkdwn', 'text': ':ok_hand: `/prof_activate_share` \n毎日18時の投稿を有効するよ' }, { 'type': 'mrkdwn', 'text': ':raised_back_of_hand: `/prof_inactivate_share` \n 毎日18時の投稿を止めるよ' } ] }, { 'type': 'divider' } ] }"
      encoded_msg = ERB::Util.url_encode(msg)
      encoded_msg
    end

    def send_help_msg
      team = Team.find_by(workspace_id: params[:team_id])
      user = User.find_by(uid: params[:event][:user])
      return if team.nil? || user.nil? || team.workspace_id != user.team.workspace_id

      access_token = set_access_token(user.authentication.access_token)
      encoded_text = get_encoded_help_text
      encoded_msg = get_encoded_help_block_msg
      access_token.post("api/chat.postMessage?channel=#{user.uid}&blocks=#{encoded_msg}&text=#{encoded_text}&pretty=1").parsed
    end

    def get_encoded_help_text
      text = 'ヘルプメッセージを送信しました'
      encoded_text = ERB::Util.url_encode(text)
      encoded_text
    end

    def get_encoded_help_block_msg
      msg = "[ { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '本アプリでは以下のコマンドがSlack内で利用できるよ:hamster:' } }, { 'type': 'section', 'fields': [ { 'type': 'mrkdwn', 'text': ':information_source: `/prof_help` \nDMでヘルプメッセージを送るよ' }, { 'type': 'mrkdwn', 'text': ':postbox: `/prof_random_block` \n DMでランダムにブロックを1つ送るよ' } ] }, { 'type': 'section', 'fields': [ { 'type': 'mrkdwn', 'text': ':ok_hand: `/prof_activate_share` \n毎日18時の投稿を有効するよ' }, { 'type': 'mrkdwn', 'text': ':raised_back_of_hand: `/prof_inactivate_share` \n 毎日18時の投稿を止めるよ' } ] }, { 'type': 'divider' } ]"
      encoded_msg = ERB::Util.url_encode(msg)
      encoded_msg
    end
  end
end
