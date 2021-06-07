module SlackBlockKit

  def get_block_kit_msg
    message = '[ { "type": "section", "text": { "type": "mrkdwn", "text": "プロフちゃんの世界へようこそ:musical_note:\nこれからよろしくお願いします！\n*<https://prof-chan.herokuapp.com/|プロフちゃんのサイト>*" } }, { "type": "divider" }, { "type": "divider" }, { "type": "section", "text": { "type": "mrkdwn", "text": "基本的にプロフィールは#プロフ共有スペースで共有するよ！あなたが入力した内容を共有チャンネルでシェアしよう！" } } ]'
    return ERB::Util.url_encode(message)
  end

  def post_questioin_block(register)
    access_token = set_access_token

    post_text = if register.question_item_content3.present? && register.question_item_answer3.present?
                  " #{register.question_item_content1}\n :arrow_right:* #{register.question_item_answer1}*\n #{register.question_item_content2}\n :arrow_right:* #{register.question_item_answer2}*\n#{register.question_item_content3}\n :arrow_right:* #{register.question_item_answer3}*\n"
                elsif register.question_item_content2.present? && register.question_item_answer2.present?
                  " #{register.question_item_content1}\n :arrow_right:* #{register.question_item_answer1}*\n #{register.question_item_content2}\n :arrow_right:* #{register.question_item_answer2}*"
                else
                  " #{register.question_item_content1}\n :arrow_right:* #{register.question_item_answer1}*"
                end
    text = "@#{current_user.name}さんがクエスチョンブロックを作成したよ:bangbang:\n タイトル: :star2:#{register.question_title} :star2:"
    msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{post_text}' }, 'accessory': { 'type': 'image', 'image_url': '#{current_user.image.to_s}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' } ]"
    encoded_msg = ERB::Util.url_encode(msg)
    encoded_text = ERB::Util.url_encode(text)
    channel_id = current_user.team.share_channel_id
    access_token.post("api/chat.postMessage?channel=#{channel_id}&blocks=#{encoded_msg}&text=#{encoded_text}&pretty=1").parsed
  end

  def set_access_token
    encrypted_access_token = current_user.access_token
    key_len = ActiveSupport::MessageEncryptor.key_len
    secret = Rails.application.key_generator.generate_key('salt', key_len)
    crypt = ActiveSupport::MessageEncryptor.new(secret)
    decrypted_access_token = crypt.decrypt_and_verify(encrypted_access_token)
    access_token = OmniAuth::Slack.build_access_token(ENV['SLACK_CLIENT_ID'], ENV['SLACK_CLIENT_SECRET'], decrypted_access_token)
    return access_token
  end

end