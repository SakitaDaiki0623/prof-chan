require 'slack-ruby-client'

module Slack
  class ApplicationController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def set_access_token(raw_access_token)
      access_token = OmniAuth::Slack.build_access_token(ENV['SLACK_CLIENT_ID'], ENV['SLACK_CLIENT_SECRET'], raw_access_token)
      access_token
    end

    def try_set_access_token_from(users)
      valid_access_token = {}
      users.each do |user|
        access_token = set_access_token(user.authentication.access_token)
        unless access_token.expired?
          valid_access_token = user.authentication.access_token.dig("access_token")
          break
        end
      end
      return valid_access_token
    end

    def convert_favorite_msg(favorite_block)
      favorite_text = "favoriteブロック\n :star2:*#{favorite_block.category.name}* :star2:"
      favorite_msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{favorite_text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{favorite_block.text}' }, 'accessory': { 'type': 'image', 'image_url': '#{favorite_block.profile_block.user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' } ]"
      encoded_msg = encode_msg(favorite_msg)
      encoded_msg
    end

    def convert_question_msg(question_block)
      question_text = "クエスチョンブロック\n :star2:*#{question_block.title}* :star2:"
      post_text = if question_block.question_items.length == 3
                    " #{question_block.question_items[0].content}\n :arrow_right:* #{question_block.question_items[0].answer}*\n #{question_block.question_items[1].content}\n :arrow_right:* #{question_block.question_items[1].answer}*\n#{question_block.question_items[2].content}\n :arrow_right:* #{question_block.question_items[2].answer}*\n"
                  elsif question_block.question_items.length == 2
                    " #{question_block.question_items[0].content}\n :arrow_right:* #{question_block.question_items[0].answer}*\n #{question_block.question_items[1].content}\n :arrow_right:* #{question_block.question_items[1].answer}*"
                  else
                    " #{question_block.question_items[0].content}\n :arrow_right:* #{question_block.question_items[0].answer}*"
                  end
      question_msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{question_text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{post_text}' }, 'accessory': { 'type': 'image', 'image_url': '#{question_block.profile_block.user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' } ]"
      encoded_msg = encode_msg(question_msg)
      encoded_msg
    end

    def convert_ranking_msg(ranking_block)
      ranking_text = "ランキングブロック\n :star2:*#{ranking_block.title}* :star2:"
      ranking_msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{ranking_text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': ':first_place_medal: #{ranking_block.first_place}\n- - - - - - - - - - - - - - - - - - - - - -\n:second_place_medal: #{ranking_block.second_place}\n- - - - - - - - - - - - - - - - - - - - - -\n:third_place_medal: #{ranking_block.third_place}' }, 'accessory': { 'type': 'image', 'image_url': '#{ranking_block.profile_block.user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' } ]"
      encoded_msg = encode_msg(ranking_msg)
      encoded_msg
    end

    def convert_yes_or_no_msg(yes_or_no_block)
      yes_or_no_text = "Yes or No ブロック\n :star2:*#{yes_or_no_block.title}* :star2:"
      post_text = if yes_or_no_block.yes_or_no_items.length == 3
                    " #{yes_or_no_block.yes_or_no_items[0].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[0].answer)}*\n #{yes_or_no_block.yes_or_no_items[1].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[1].answer)}*\n#{yes_or_no_block.yes_or_no_items[2].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[2].answer)}*\n"
                  elsif yes_or_no_block.yes_or_no_items.length == 2
                    " #{yes_or_no_block.yes_or_no_items[0].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[0].answer)}*\n #{yes_or_no_block.yes_or_no_items[1].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[1].answer)}*"
                  else
                    " #{yes_or_no_block.yes_or_no_items[0].content}\n :arrow_right: *#{translate_boolean(yes_or_no_block.yes_or_no_items[0].answer)}*"
                  end
      yes_or_no_msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{yes_or_no_text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{post_text}' }, 'accessory': { 'type': 'image', 'image_url': '#{yes_or_no_block.profile_block.user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' } ]"
      encoded_msg = encode_msg(yes_or_no_msg)
      encoded_msg
    end

    def translate_boolean(answer)
      answer ? 'YES！:laughing:' : 'NO！ :weary:'
    end

    def convert_text_msg(text_block)
      text_text = "テキストブロック\n :star2:*#{text_block.title}* :star2:"
      text_msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{text_text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{text_block.text}' }, 'accessory': { 'type': 'image', 'image_url': '#{text_block.profile_block.user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' } ]"
      encoded_msg = encode_msg(text_msg)
      encoded_msg
    end

    def encode_msg(msg)
      encoded_msg = ERB::Util.url_encode(msg)
      encoded_msg
    end

    def set_client(token)
      Slack.configure do |config|
        config.token = token
        fail 'Missing API token' unless config.token
      end
      client = Slack::Web::Client.new
      test_res = client.auth_test
      return unless test_res.dig("ok")
      return client
    end

    def get_please_login_message
      text = ":warning: *Slackログインが必要です！！*:warning: \n Slashコマンドを利用するにはアプリでSlackログインをする必要があります。このワークスペースを指定して本サービスにSlackログインをするとSlashコマンドがご利用できます \n :arrow_right:   <https://www.prof-chan.com/agreement/|ログインページ>で今すぐログイン！"
    end

    def send_please_login_msg
      uid = params[:user_id]
      team = Team.find_by(workspace_id: params[:team_id])
      access_token_for_client = try_set_access_token_from(team.users)
      client = set_client(access_token_for_client)
      text = get_please_login_message
      client.chat_postMessage(channel: uid, text: text)
    end
  end
end
