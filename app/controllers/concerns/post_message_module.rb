module PostMessageModule
  def post_questioin_block(register)
    access_token = set_access_token
    text = "<@#{current_user.uid}>さんがクエスチョンブロックを作成したよ:hamster:\n :star2:*#{register.question_title}*:star2:"
    post_text = if register.question_item_content3.present? && register.question_item_answer3.present?
                  " #{register.question_item_content1}\n :arrow_right:* #{register.question_item_answer1}*\n #{register.question_item_content2}\n :arrow_right:* #{register.question_item_answer2}*\n#{register.question_item_content3}\n :arrow_right:* #{register.question_item_answer3}*\n"
                elsif register.question_item_content2.present? && register.question_item_answer2.present?
                  " #{register.question_item_content1}\n :arrow_right:* #{register.question_item_answer1}*\n #{register.question_item_content2}\n :arrow_right:* #{register.question_item_answer2}*"
                else
                  " #{register.question_item_content1}\n :arrow_right:* #{register.question_item_answer1}*"
                end
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{post_text}' }, 'accessory': { 'type': 'image', 'image_url': '#{current_user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{user_profile_link}' } }, { 'type': 'divider' } ]"
    post_block(text, msg, access_token)
  end

  def post_yes_or_no_block(register)
    access_token = set_access_token
    text = "<@#{current_user.uid}>さんがYes or No ブロックを作成したよ:hamster:\n :star2:*#{register.yes_or_no_title}* :star2:"
    post_text = if register.yes_or_no_item_content3.present?
                  " #{register.yes_or_no_item_content1}\n :arrow_right:* #{translate_boolean(register.yes_or_no_item_answer1)}*\n #{register.yes_or_no_item_content2}\n :arrow_right:* #{translate_boolean(register.yes_or_no_item_answer2)}*\n#{register.yes_or_no_item_content3}\n :arrow_right:* #{translate_boolean(register.yes_or_no_item_answer3)}*\n"
                elsif register.yes_or_no_item_content2.present?
                  " #{register.yes_or_no_item_content1}\n :arrow_right:* #{translate_boolean(register.yes_or_no_item_answer1)}*\n #{register.yes_or_no_item_content2}\n :arrow_right:* #{translate_boolean(register.yes_or_no_item_answer2)}*"
                else
                  " #{register.yes_or_no_item_content1}\n :arrow_right: *#{translate_boolean(register.yes_or_no_item_answer1)}*"
                end
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{post_text}' }, 'accessory': { 'type': 'image', 'image_url': '#{current_user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{user_profile_link}' } }, { 'type': 'divider' } ]"
    post_block(text, msg, access_token)
  end

  def translate_boolean(answer)
    answer ? 'YES！:laughing:' : 'NO！ :weary:'
  end

  def post_ranking_block(block)
    access_token = set_access_token
    text = "<@#{current_user.uid}>さんがランキングブロックを作成したよ:hamster:\n :star2:*#{block.title}* :star2:"
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': ':first_place_medal: #{block.first_place}\n- - - - - - - - - - - - - - - - - - - - - -\n:second_place_medal: #{block.second_place}\n- - - - - - - - - - - - - - - - - - - - - -\n:third_place_medal: #{block.third_place}' }, 'accessory': { 'type': 'image', 'image_url': '#{current_user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{user_profile_link}' } }, { 'type': 'divider' } ]"
    post_block(text, msg, access_token)
  end

  def post_text_block(block)
    access_token = set_access_token
    text = "<@#{current_user.uid}>さんがテキストブロックを作成したよ:hamster:\n :star2:*#{block.title}* :star2:"
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{block.text}' }, 'accessory': { 'type': 'image', 'image_url': '#{current_user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{user_profile_link}' } }, { 'type': 'divider' } ]"
    post_block(text, msg, access_token)
  end

  def set_access_token
    raw_access_token = current_user.authentication.access_token
    access_token = OmniAuth::Slack.build_access_token(ENV['SLACK_CLIENT_ID'], ENV['SLACK_CLIENT_SECRET'], raw_access_token)
    access_token
  end

  def user_profile_link
    ":hamster:<https://www.prof-chan.com/profiles/#{current_user.profile.public_uid}/|#{current_user.name}さんのプロフページ>:hamster:"
  end

  def post_block(text, msg, access_token)
    channel_id = current_user.team.share_channel_id
    encoded_msg = ERB::Util.url_encode(msg)
    encoded_text = ERB::Util.url_encode(text)
    access_token.post("api/chat.postMessage?channel=#{channel_id}&blocks=#{encoded_msg}&text=#{encoded_text}&pretty=1").parsed
  end
end
