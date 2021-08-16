
module Slack
  class AppHomeOpenedController < Slack::ApplicationController
    def respond
      if params[:challenge].present?
        render json: params[:challenge], status: 200
      elsif params[:event][:type] == 'app_home_opened'
        app_home_publish
      else params[:event][:type] == 'message' && params[:event][:text].present?
        send_help_msg
      end
    end

    def app_home_publish
      team = Team.find_by(workspace_id: params[:team_id])
      users = team.users
      access_token = try_set_access_token_from(users)
      client = set_client(access_token)
      user_id = params[:event][:user]
      view = initial_home_view
      res = client.views_publish(user_id: user_id, view: view)
    end

    def publish_to_home_tab(team, user_id, access_token)
      encoded_msg = encoded_home_tab_block_msg
      access_token.post("api/views.publish?user_id=#{user_id}&view=#{encoded_msg}&pretty=1").parsed
    end

    def initial_home_view
      view =
      {
        "type": "home",
        "blocks": [
          {
            "type": "divider"
          },
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "*投稿機能について*\n --------------------------------------------- \n :eight_spoked_asterisk:  各ブロックの投稿 \n 各ブロックを1日に一度投稿することができるよ:star:\nみんなに共有したいことを投稿してみよう！\n --------------------------------------------- \n:sparkle:  毎日18時の自動投稿 \n毎日18時にチーム内の各ブロックを投稿するよ:star: \n あなたのブロックが選ばれたら嬉しいな！"
            }
          },
          {
            "type": "divider"
          },
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "*Slashコマンドについて*\n本アプリでは以下のコマンドがSlack内で利用できるよ:hamster:"
            }
          },
          {
            "type": "section",
            "fields": [
              {
                "type": "mrkdwn",
                "text": ":information_source: `/prof_help` \nDMでヘルプメッセージを送るよ"
              },
              {
                "type": "mrkdwn",
                "text": ":postbox: `/prof_random_block` \n DMでランダムにブロックを1つ送るよ"
              }
            ]
          },
          {
            "type": "section",
            "fields": [
              {
                "type": "mrkdwn",
                "text": ":ok_hand: `/prof_activate_share` \n毎日18時の投稿を有効するよ"
              },
              {
                "type": "mrkdwn",
                "text": ":raised_back_of_hand: `/prof_deactivate_share` \n 毎日18時の投稿を止めるよ"
              }
            ]
          },
          {
            "type": "divider"
          }
        ]
      }.to_json
      view
    end

    def send_help_msg
      p "====================start send_help_msg===================="
      team = Team.find_by(workspace_id: params[:team_id])
      users = team.users
      access_token = try_set_access_token_from(users)
      client = set_client(access_token)
      user_id = params[:event][:user]
      text = get_help_msg
      client.chat_postMessage(channel: user_id, text: text)
    end

    def get_encoded_help_text
      text = 'ヘルプメッセージを送信しました'
      encoded_text = ERB::Util.url_encode(text)
      encoded_text
    end

    def get_help_msg
      msg = "お困りの際はホームタブを確認してね!!!! :hamster:"
      msg
    end
  end
end
