module PostMessageModule
  def post_question_block(register)
    text = "<@#{current_user.uid}>さんがクエスチョンブロックを作成したよ:hamster:\n :star2:*#{register.question_title}*:star2:"
    post_text = if register.question_item_content3.present? && register.question_item_answer3.present?
                  " #{register.question_item_content1}\n :arrow_right:* #{register.question_item_answer1}*\n #{register.question_item_content2}\n :arrow_right:* #{register.question_item_answer2}*\n#{register.question_item_content3}\n :arrow_right:* #{register.question_item_answer3}*\n"
                elsif register.question_item_content2.present? && register.question_item_answer2.present?
                  " #{register.question_item_content1}\n :arrow_right:* #{register.question_item_answer1}*\n #{register.question_item_content2}\n :arrow_right:* #{register.question_item_answer2}*"
                else
                  " #{register.question_item_content1}\n :arrow_right:* #{register.question_item_answer1}*"
                end
    msg = Slack::BlockKitMessage.question_block_msg_when_post_to_slack(text, post_text, current_user, user_profile_link)
    post_block(text, msg)
  end

  def post_yes_or_no_block(register)
    text = "<@#{current_user.uid}>さんがYes or No ブロックを作成したよ:hamster:\n :star2:*#{register.yes_or_no_title}* :star2:"
    post_text = if register.yes_or_no_item_content3.present?
                  " #{register.yes_or_no_item_content1}\n :arrow_right:* #{translate_boolean(register.yes_or_no_item_answer1)}*\n #{register.yes_or_no_item_content2}\n :arrow_right:* #{translate_boolean(register.yes_or_no_item_answer2)}*\n#{register.yes_or_no_item_content3}\n :arrow_right:* #{translate_boolean(register.yes_or_no_item_answer3)}*\n"
                elsif register.yes_or_no_item_content2.present?
                  " #{register.yes_or_no_item_content1}\n :arrow_right:* #{translate_boolean(register.yes_or_no_item_answer1)}*\n #{register.yes_or_no_item_content2}\n :arrow_right:* #{translate_boolean(register.yes_or_no_item_answer2)}*"
                else
                  " #{register.yes_or_no_item_content1}\n :arrow_right: *#{translate_boolean(register.yes_or_no_item_answer1)}*"
                end
    msg = Slack::BlockKitMessage.yes_or_no_block_msg_when_post_to_slack(text, post_text, current_user, user_profile_link)
    post_block(text, msg)
  end

  def translate_boolean(answer)
    answer ? 'YES！:laughing:' : 'NO！ :weary:'
  end

  def post_ranking_block(block)
    text = "<@#{current_user.uid}>さんがランキングブロックを作成したよ:hamster:\n :star2:*#{block.title}* :star2:"
    msg = Slack::BlockKitMessage.ranking_block_msg_when_post_to_slack(text, block, current_user, user_profile_link)
    post_block(text, msg)
  end

  def post_text_block(block)
    text = "<@#{current_user.uid}>さんがテキストブロックを作成したよ:hamster:\n :star2:*#{block.title}* :star2:"
    msg = Slack::BlockKitMessage.text_block_msg_when_post_to_slack(text, block, current_user, user_profile_link)
    post_block(text, msg)
  end

  def set_access_token
    hash_token = current_user.authentication.access_token
    access_token = Slack::AccessToken.set_access_token(hash_token)
    access_token
  end

  def post_block(text, msg)
    Slack::ApiMethod.chat_post_message(access_token: set_access_token, channel_id: current_user_share_channel_id, encoded_msg: msg, encoded_text: ERB::Util.url_encode(text))
  end

  def current_user_share_channel_id
    current_user.team.share_channel_id
  end

  def user_profile_link
    ":hamster:<https://www.prof-chan.com/profiles/#{current_user.profile.public_uid}/|#{current_user.name}さんのプロフページ>:hamster:"
  end
end
