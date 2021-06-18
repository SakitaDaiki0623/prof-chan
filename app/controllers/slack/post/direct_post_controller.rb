module Slack
  module Post
    class DirectPostController < Slack::ApplicationController
      before_action :set_user_and_token, only: %i[help random_block]

      def help
        text = "ヘルプメッセージを送信しました:hamster:"
        encoded_text = ERB::Util.url_encode(text)
        encoded_msg = get_encoded_help_message
        post_direct_message(encoded_text, encoded_msg, @uid, @access_token)
      end

      def get_encoded_help_message
        msg = '[ { "type": "section", "text": { "type": "mrkdwn", "text": ":hamster:プロフちゃんの使い方" } }, { "type": "divider" }, { "type": "section", "fields": [ { "type": "mrkdwn", "text": ":information_source: `/prof_help` \nDMでヘルプメッセージを送るよ" }, { "type": "mrkdwn", "text": ":postbox: `/prof_random_block` \n DMでランダムにブロックを1つ送るよ" } ] }, { "type": "section", "fields": [ { "type": "mrkdwn", "text": ":ok_hand: `/activate_share` \n毎日18時の投稿を有効するよ" }, { "type": "mrkdwn", "text": ":raised_back_of_hand: `/inactivate_share` \n 毎日18時の投稿を止めるよ" } ] } ]'
        encoded_msg = encode_msg(msg)
        return encoded_msg
      end

      def random_block
        block = pick_up_block(@user)
        if block.present?
          text = "ランダムにブロックを送信:hamster:"
          encoded_text = ERB::Util.url_encode(text)
          encoded_msg = convert_block_msg(block)
          post_direct_message(encoded_text, encoded_msg, @uid, @access_token)
        else
          text = "まだあなた以外のブロックが作成されていないよ、、、:cry: \n プロフちゃんをもっと社内に広めよう！"
          encoded_text = ERB::Util.url_encode(text)
          post_no_block(encoded_text, @uid, @access_token)
        end
      end

      def pick_up_block(user)
        favorite_block = FavoriteBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).where.not(users: { id: user.id }).sample
        question_block = QuestionBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).where.not(users: { id: user.id }).sample
        ranking_block = RankingBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).where.not(users: { id: user.id }).sample
        yes_or_no_block = YesOrNoBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).where.not(users: { id: user.id }).sample
        text_block = TextBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).where.not(users: { id: user.id }).sample
        block = [favorite_block, question_block, ranking_block, yes_or_no_block, text_block].sample
        return block
      end

      def convert_block_msg(block)
        msg = convert_favorite_msg(block) if block.class == FavoriteBlock
        msg = convert_question_msg(block) if block.class == QuestionBlock
        msg = convert_ranking_msg(block) if block.class == RankingBlock
        msg = convert_yes_or_no_msg(block) if block.class == YesOrNoBlock
        msg = convert_text_msg(block) if block.class == TextBlock
        return msg
      end

      def post_direct_message(encoded_text, encoded_msg, channel_id, access_token)
        access_token.post("api/chat.postMessage?channel=#{channel_id}&blocks=#{encoded_msg}&text=#{encoded_text}&pretty=1").parsed
      end

      def post_no_block(encoded_text, channel_id, access_token)
        access_token.post("api/chat.postMessage?channel=#{channel_id}&text=#{encoded_text}&pretty=1").parsed
      end

      def set_user_and_token
        @user = User.find_by(uid: params[:user_id])
        return if @user.nil?
        @uid = @user.uid
        @access_token = set_access_token(@user.authentication.access_token)
      end
    end
  end
end