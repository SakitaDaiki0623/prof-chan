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
          encoded_msg = Slack::BlockKitMessage.help_msg
          Slack::ApiMethod.chat_post_message(access_token: access_token, channel_id: user_id, encoded_msg: encoded_msg, encoded_text: encoded_text)
        end
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
            Slack::ApiMethod.chat_post_message(access_token: access_token, channel_id: channel_id, encoded_msg: encoded_msg, encoded_text: encoded_text)
          else
            text = "あなた以外のプロフィールに作成されたブロック（favoriteブロック、クエスチョンブロック、ランキングブロック、Yes or No ブロックブロック、テキストブロック）が1つもないよ、、、:cry: \n 他の社員にもっとブロックを作成してもらえるように頼んでみよう！:hamster:"
            encoded_text = ERB::Util.url_encode(text)
            post_no_block(encoded_text, uid, access_token)
          end
        end
      end

      private

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
