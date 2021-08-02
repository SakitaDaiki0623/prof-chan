namespace :blocks do
  top_level = self

  using Module.new {
    refine(top_level.singleton_class) do
      def post_block(text, msg, channel_id, access_token)
        encoded_msg = ERB::Util.url_encode(msg)
        encoded_text = ERB::Util.url_encode(text)
        access_token.post("api/chat.postMessage?channel=#{channel_id}&blocks=#{encoded_msg}&text=#{encoded_text}&pretty=1").parsed
      end

      def user_profile_link(user)
        ":hamster:<https://www.prof-chan.com/profiles/#{user.profile.public_uid}/|#{user.name}さんのプロフページ>:hamster:"
      end

      def translate_boolean(answer)
        answer ? 'YES！:laughing:' : 'NO！ :weary:'
      end
    end
  }

  desc '各チームに存在する各タイプのブロックをプロフ投稿チャンネルに投稿'
  task post_blocks: :environment do
    Team.all.includes(:users).each do |team|
      logger.debug 'post_blocks started!'
      # 通常ログインはプロフィール公開しない
      next if team.users.count.zero? || team.users[0].provider == 'email' || team.share_right_inactive?

      # 各ブロックをランダムに1つ取得する
      logger.debug 'selecting blocks...'
      favorite_block = FavoriteBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: team.workspace_id }).sample
      question_block = QuestionBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: team.workspace_id }).sample
      ranking_block = RankingBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: team.workspace_id }).sample
      yes_or_no_block = YesOrNoBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: team.workspace_id }).sample
      text_block = TextBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: team.workspace_id }).sample

      # 全てのブロックがない場合は投稿しない
      next if favorite_block.nil? && question_block.nil? && ranking_block.nil? && yes_or_no_block.nil? && text_block.nil?

      logger.info 'possible to post blocks!'

      # アクセストークンの生成
      logger.debug 'creating access_token...'
      token_test_result = ''
      access_token = ''
      team.users.each do |user|
        raw_access_token = user.authentication.access_token
        access_token = OmniAuth::Slack.build_access_token(ENV['SLACK_CLIENT_ID'], ENV['SLACK_CLIENT_SECRET'], raw_access_token)
        token_test_result = access_token.post('api/auth.test').parsed
        break if token_test_result.dig('ok')
      end
      # 最後のtoken_test_resultもfalseであるならば投稿はできないので次に進む
      next unless token_test_result.dig('ok')

      logger.info  'created access_token!'

      # 投稿先チャンネルIDの取得
      channel_id = team.share_channel_id

      # プロフちゃんのメッセージを最初に送信
      prof_text = '本日の社員紹介!:hamster:'
      prof_msg = '[ { "type": "section", "text": { "type": "mrkdwn", "text": "本日の社員紹介!:hamster: \n 今日も社員さんの中から素敵なブロックを紹介します！:star2: \n 気になった話題には是非スタンプを押してね:thumbsup:" } }, { "type": "divider" }, { "type": "divider" } ]'
      post_block(prof_text, prof_msg, channel_id, access_token)

      # 各ブロックを共有スペースに投稿する===================
      logger.debug 'posting blocks...'
      begin
        ## favoriteブロック
        if favorite_block.present?
          logger.debug 'posting favorite_block...'
          favorite_text = " `favoriteブロック` \n :star2:*#{favorite_block.category.name}* :star2:"
          favorite_msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{favorite_text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{favorite_block.text}' }, 'accessory': { 'type': 'image', 'image_url': '#{favorite_block.profile_block.user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{user_profile_link(favorite_block.profile_block.user)}' } }, { 'type': 'divider' } ]"
          post_block(favorite_text, favorite_msg, channel_id, access_token)
          logger.info  'posted favorite_block!'
        end
        ## クエスチョンブロック
        if question_block.present?
          logger.debug 'posting question_block...'
          question_text = " `クエスチョンブロック` \n :star2:*#{question_block.title}* :star2:"
          post_text = if question_block.question_items.length == 3
                        " #{question_block.question_items[0].content}\n :arrow_right:* #{question_block.question_items[0].answer}*\n #{question_block.question_items[1].content}\n :arrow_right:* #{question_block.question_items[1].answer}*\n#{question_block.question_items[2].content}\n :arrow_right:* #{question_block.question_items[2].answer}*\n"
                      elsif question_block.question_items.length == 2
                        " #{question_block.question_items[0].content}\n :arrow_right:* #{question_block.question_items[0].answer}*\n #{question_block.question_items[1].content}\n :arrow_right:* #{question_block.question_items[1].answer}*"
                      else
                        " #{question_block.question_items[0].content}\n :arrow_right:* #{question_block.question_items[0].answer}*"
                      end
          question_msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{question_text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{post_text}' }, 'accessory': { 'type': 'image', 'image_url': '#{question_block.profile_block.user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{user_profile_link(question_block.profile_block.user)}' } }, { 'type': 'divider' } ]"
          post_block(question_text, question_msg, channel_id, access_token)
          logger.info  'posted question_block!'
        end
        ## ランキングブロック
        if ranking_block.present?
          logger.debug 'posting ranking_block...'
          ranking_text = " `ランキングブロック` \n :star2:*#{ranking_block.title}* :star2:"
          ranking_msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{ranking_text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': ':first_place_medal: #{ranking_block.first_place}\n- - - - - - - - - - - - - - - - - - - - - -\n:second_place_medal: #{ranking_block.second_place}\n- - - - - - - - - - - - - - - - - - - - - -\n:third_place_medal: #{ranking_block.third_place}' }, 'accessory': { 'type': 'image', 'image_url': '#{ranking_block.profile_block.user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{user_profile_link(ranking_block.profile_block.user)}' } }, { 'type': 'divider' } ]"
          post_block(ranking_text, ranking_msg, channel_id, access_token)
          logger.info  'posted ranking_block!'
        end
        ## yes or Yes or No ブロック
        if yes_or_no_block.present?
          logger.debug 'posting yes_or_no_block...'
          yes_or_no_text = " `Yes or No ブロック` \n :star2:*#{yes_or_no_block.title}* :star2:"
          post_text = if yes_or_no_block.yes_or_no_items.length == 3
                        " #{yes_or_no_block.yes_or_no_items[0].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[0].answer)}*\n #{yes_or_no_block.yes_or_no_items[1].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[1].answer)}*\n#{yes_or_no_block.yes_or_no_items[2].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[2].answer)}*\n"
                      elsif yes_or_no_block.yes_or_no_items.length == 2
                        " #{yes_or_no_block.yes_or_no_items[0].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[0].answer)}*\n #{yes_or_no_block.yes_or_no_items[1].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[1].answer)}*"
                      else
                        " #{yes_or_no_block.yes_or_no_items[0].content}\n :arrow_right: *#{translate_boolean(yes_or_no_block.yes_or_no_items[0].answer)}*"
                      end
          yes_or_no_msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{yes_or_no_text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{post_text}' }, 'accessory': { 'type': 'image', 'image_url': '#{yes_or_no_block.profile_block.user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{user_profile_link(yes_or_no_block.profile_block.user)}' } }, { 'type': 'divider' } ]"
          post_block(yes_or_no_text, yes_or_no_msg, channel_id, access_token)
          logger.info  'posted yes_or_no_block!'
        end
        ## テキストブロック
        if text_block.present?
          logger.debug 'posting text_block...'
          text_text = " `テキストブロック` \n :star2:*#{text_block.title}* :star2:"
          text_msg = "[ { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{text_text}' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{text_block.text}' }, 'accessory': { 'type': 'image', 'image_url': '#{text_block.profile_block.user.image}', 'alt_text': 'computer thumbnail' } }, { 'type': 'divider' }, { 'type': 'section', 'text': { 'type': 'mrkdwn', 'text': '#{user_profile_link(text_block.profile_block.user)}' } }, { 'type': 'divider' } ]"
          post_block(text_text, text_msg, channel_id, access_token)
          logger.info 'posted text_block!'
        end
      rescue StandardError => e
        logger.debug e.message
      end
      logger.info 'finised posting blocks!'
    end
  end
end
