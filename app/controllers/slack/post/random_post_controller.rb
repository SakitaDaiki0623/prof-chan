module Slack
  module Post
    class RandomPostController < Slack::ApplicationController
      before_action :set_user_team_token, only: %i[random_block]

      def random_block
        return if @user.nil?
        block = pick_up_block(@user)
        return if block.nil?
        encoded_msg = convert_block_msg(block)
        post_block(@encoded_text, encoded_msg, @uid, @access_token)
      end

      def pick_up_block(user)
        favorite_block = FavoriteBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).sample
        question_block = QuestionBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).sample
        ranking_block = RankingBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).sample
        yes_or_no_block = YesOrNoBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).sample
        text_block = TextBlock.all.includes(profile_block: { user: :team }).where(teams: { workspace_id: user.team.workspace_id }).sample
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

      def post_block(encoded_text, encoded_msg, channel_id, access_token)
        access_token.post("api/chat.postMessage?channel=#{channel_id}&blocks=#{encoded_msg}&text=#{encoded_text}&pretty=1").parsed
      end

      def set_user_team_token
        @user = User.find_by(uid: params[:user_id])
        return if @user.nil?
        @uid = @user.uid
        @text = "ランダムにブロックを送信:hamster:"
        @encoded_text = ERB::Util.url_encode(@text)
        @access_token = set_access_token(@user.authentication.access_token)
      end
    end
  end
end