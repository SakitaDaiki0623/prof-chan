module Slack
  module Post
    class DirectPostController < Slack::ApplicationController
      before_action :set_user, only: %i[help random_block]

      def help
        if @user.nil?
          send_please_login_msg
        else
          user_id = @user.uid
          access_token = set_access_token(@user.authentication.access_token)
          text = 'ヘルプメッセージを送信しました:hamster:'
          encoded_text = ERB::Util.url_encode(text)
          encoded_msg = get_encoded_help_message
          SlackApiMethod.chat_post_message(access_token, user_id, encoded_msg, encoded_text)
        end
      end

      def get_encoded_help_message
        msg = '[ { "type": "section", "text": { "type": "mrkdwn", "text": ":hamster:プロフちゃんの使い方" } }, { "type": "divider" }, { "type": "section", "fields": [ { "type": "mrkdwn", "text": ":information_source: `/prof_help` \nDMでヘルプメッセージを送るよ" }, { "type": "mrkdwn", "text": ":postbox: `/prof_random_block` \n DMでランダムにブロックを1つ送るよ" } ] }, { "type": "section", "fields": [ { "type": "mrkdwn", "text": ":ok_hand: `/prof_activate_share` \n毎日18時の投稿を有効するよ" }, { "type": "mrkdwn", "text": ":raised_back_of_hand: `/prof_deactivate_share` \n 毎日18時の投稿を止めるよ" } ] } ]'
        encoded_msg = encode_msg(msg)
        encoded_msg
      end

      def random_block
        if @user.nil?
          send_please_login_msg
        else
          block = pick_up_block(@user)
          user_id = @user.uid
          access_token = set_access_token(@user.authentication.access_token)
          if block.present?
            text = 'ランダムにブロックを送信:hamster:'
            encoded_text = ERB::Util.url_encode(text)
            encoded_msg = convert_block_msg(block)
            SlackApiMethod.chat_post_message(access_token, user_id, encoded_msg, encoded_text)
          else
            text = "あなた以外のプロフィールに作成されたブロック（favoriteブロック、クエスチョンブロック、ランキングブロック、Yes or No ブロックブロック、テキストブロック）が1つもないよ、、、:cry: \n 他の社員にもっとブロックを作成してもらえるように頼んでみよう！:hamster:"
            encoded_text = ERB::Util.url_encode(text)
            post_no_block(encoded_text, uid, access_token)
          end
        end
      end

      def pick_up_block(user)
        favorite_block = FavoriteBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).where.not(users: { id: user.id }).sample
        question_block = QuestionBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).where.not(users: { id: user.id }).sample
        ranking_block = RankingBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).where.not(users: { id: user.id }).sample
        yes_or_no_block = YesOrNoBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).where.not(users: { id: user.id }).sample
        text_block = TextBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).where.not(users: { id: user.id }).sample
        blocks = []
        [favorite_block, question_block, ranking_block, yes_or_no_block, text_block].each do |block|
          blocks.push(block) if block.present?
        end
        block = blocks.sample
        block
      end

      def convert_block_msg(block)
        msg = convert_favorite_msg(block) if block.class == FavoriteBlock
        msg = convert_question_msg(block) if block.class == QuestionBlock
        msg = convert_ranking_msg(block) if block.class == RankingBlock
        msg = convert_yes_or_no_msg(block) if block.class == YesOrNoBlock
        msg = convert_text_msg(block) if block.class == TextBlock
        msg
      end

      def post_no_block(encoded_text, channel_id, access_token)
        access_token.post("api/chat.postMessage?channel=#{channel_id}&text=#{encoded_text}&pretty=1").parsed
      end

      def set_user
        @user = User.find_by(uid: params[:user_id])
      end
    end
  end
end
