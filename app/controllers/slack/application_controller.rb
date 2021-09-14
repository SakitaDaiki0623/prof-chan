require 'slack-ruby-client'

module Slack
  class ApplicationController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def try_set_access_token_from(users)
      valid_access_token = {}
      users.each do |user|
        access_token = Slack::AccessToken.make_access_token(user.authentication.access_token)
        unless access_token.expired?
          valid_access_token = client_token_from(user)
          break
        end
      end
      valid_access_token
    end

    def client_token_from(user)
      user.authentication.access_token.dig('access_token')
    end

    def set_client(token)
      Slack.configure do |config|
        config.token = token
        raise 'Missing API token' unless config.token
      end
      client = Slack::Web::Client.new
      client
    end

    def client_valid?(client)
      test_res = client.auth_test
      res_ok?(test_res)
    end

    def res_ok?(res)
      res.dig('ok')
    end

    def send_please_login_msg
      team = Team.find_by(workspace_id: params[:team_id])
      access_token_for_client = try_set_access_token_from(team.users)
      client = set_client(access_token_for_client)
      text = get_please_login_message
      client.chat_postMessage(channel: params[:user_id], text: text)
    end

    def get_please_login_message
      text = ":warning: *Slackログインが必要です！！*:warning: \n Slashコマンドを利用するにはアプリでSlackログインをする必要があります。このワークスペースを指定して本サービスにSlackログインをするとSlashコマンドがご利用できます \n :arrow_right:   <https://www.prof-chan.com/agreement/|ログインページ>で今すぐログイン！"
      text
    end
  end
end
