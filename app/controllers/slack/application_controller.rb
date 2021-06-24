module Slack
  class ApplicationController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!

    def set_access_token(encrypted_access_token)
      key_len = ActiveSupport::MessageEncryptor.key_len
      secret = Rails.application.key_generator.generate_key('salt', key_len)
      crypt = ActiveSupport::MessageEncryptor.new(secret)
      while encrypted_access_token.is_a?(String)
        encrypted_access_token = crypt.decrypt_and_verify(encrypted_access_token)
      end
      access_token = OmniAuth::Slack.build_access_token(ENV['SLACK_CLIENT_ID'], ENV['SLACK_CLIENT_SECRET'], encrypted_access_token)
      access_token
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
  end
end
