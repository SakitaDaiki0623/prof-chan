module Slack
  module SlashCommand
    class RandomBlock
      def self.post_random_block(user)
        access_token = Slack::AccessToken.make_access_token(user.authentication.access_token)
        block = pick_up_block(user)
        post_in_either_way(user: user, block: block, access_token: access_token)
      end

      def self.pick_up_block(user)
        favorite_block = FavoriteBlock.random_other_user_block(user).sample
        question_block = QuestionBlock.random_other_user_block(user).sample
        ranking_block = RankingBlock.random_other_user_block(user).sample
        yes_or_no_block = YesOrNoBlock.random_other_user_block(user).sample
        text_block = TextBlock.random_other_user_block(user).sample
        blocks = get_present_blocks(favorite_block, question_block, ranking_block, yes_or_no_block, text_block)
        block = blocks.sample
        block
      end

      def self.get_present_blocks(*blocks)
        blocks.select(&:present?)
      end

      def self.post_in_either_way(user:, block:, access_token:)
        if block.present?
          post_block_normally(user: user, block: block, access_token: access_token)
        else
          post_no_block(user: user, access_token: access_token)
        end
      end

      def self.post_block_normally(user:, block:, access_token:)
        text = 'ランダムにブロックを送信:hamster:'
        encoded_msg = convert_block_msg(block)
        Slack::ApiMethod.chat_post_message(access_token: access_token, channel_id: user.uid, encoded_msg: encoded_msg, encoded_text: ERB::Util.url_encode(text))
      end

      def self.convert_block_msg(block)
        msg = convert_favorite_msg(block) if block.class == FavoriteBlock
        msg = convert_question_msg(block) if block.class == QuestionBlock
        msg = convert_ranking_msg(block) if block.class == RankingBlock
        msg = convert_yes_or_no_msg(block) if block.class == YesOrNoBlock
        msg = convert_text_msg(block) if block.class == TextBlock
        msg
      end

      def self.convert_favorite_msg(favorite_block)
        favorite_text = "favoriteブロック\n :star2:*#{favorite_block.category.name}* :star2:"
        favorite_msg = Slack::BlockKitMessage.favorite_block_msg_when_post_to_slack(favorite_text, favorite_block, user_from(favorite_block), user_profile_link(user_from(favorite_block)))
        favorite_msg
      end

      def self.user_from(block)
        block.profile_block.user
      end

      def self.convert_question_msg(question_block)
        question_text = "クエスチョンブロック\n :star2:*#{question_block.title}* :star2:"
        post_text = get_question_post_text(question_block)
        question_msg = Slack::BlockKitMessage.question_block_msg_when_post_to_slack(question_text, post_text, user_from(question_block), user_profile_link(user_from(question_block)))
        question_msg
      end

      def self.convert_ranking_msg(ranking_block)
        ranking_text = "ランキングブロック\n :star2:*#{ranking_block.title}* :star2:"
        ranking_msg = Slack::BlockKitMessage.ranking_block_msg_when_post_to_slack(ranking_text, ranking_block, user_from(ranking_block), user_profile_link(user_from(ranking_block)))
        ranking_msg
      end

      def self.convert_yes_or_no_msg(yes_or_no_block)
        yes_or_no_text = "Yes or No ブロック\n :star2:*#{yes_or_no_block.title}* :star2:"
        post_text = get_yes_or_no_post_text(yes_or_no_block)
        yes_or_no_msg = Slack::BlockKitMessage.yes_or_no_block_msg_when_post_to_slack(yes_or_no_text, post_text, user_from(yes_or_no_block), user_profile_link(user_from(yes_or_no_block)))
        yes_or_no_msg
      end

      def self.convert_text_msg(text_block)
        text_text = "テキストブロック\n :star2:*#{text_block.title}* :star2:"
        text_msg = Slack::BlockKitMessage.ranking_block_msg_when_post_to_slack(text_text, text_block, user_from(text_block), user_profile_link(user_from(text_block)))
        text_msg
      end

      def self.get_question_post_text(question_block)
        if question_block.question_items.length == 3
          " #{question_block.question_items[0].content}\n :arrow_right:* #{question_block.question_items[0].answer}*\n #{question_block.question_items[1].content}\n :arrow_right:* #{question_block.question_items[1].answer}*\n#{question_block.question_items[2].content}\n :arrow_right:* #{question_block.question_items[2].answer}*\n"
        elsif question_block.question_items.length == 2
          " #{question_block.question_items[0].content}\n :arrow_right:* #{question_block.question_items[0].answer}*\n #{question_block.question_items[1].content}\n :arrow_right:* #{question_block.question_items[1].answer}*"
        else
          " #{question_block.question_items[0].content}\n :arrow_right:* #{question_block.question_items[0].answer}*"
        end
      end

      def self.get_yes_or_no_post_text(yes_or_no_block)
        if yes_or_no_block.yes_or_no_items.length == 3
          " #{yes_or_no_block.yes_or_no_items[0].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[0].answer)}*\n #{yes_or_no_block.yes_or_no_items[1].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[1].answer)}*\n#{yes_or_no_block.yes_or_no_items[2].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[2].answer)}*\n"
        elsif yes_or_no_block.yes_or_no_items.length == 2
          " #{yes_or_no_block.yes_or_no_items[0].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[0].answer)}*\n #{yes_or_no_block.yes_or_no_items[1].content}\n :arrow_right:* #{translate_boolean(yes_or_no_block.yes_or_no_items[1].answer)}*"
        else
          " #{yes_or_no_block.yes_or_no_items[0].content}\n :arrow_right: *#{translate_boolean(yes_or_no_block.yes_or_no_items[0].answer)}*"
        end
      end

      def self.translate_boolean(answer)
        answer ? 'YES！:laughing:' : 'NO！ :weary:'
      end

      def self.user_profile_link(user)
        ":hamster:<https://www.prof-chan.com/profiles/#{user.profile.public_uid}/|#{user.name}さんのプロフページ>:hamster:"
      end

      def self.post_no_block(user:, access_token:)
        text = "あなた以外のプロフィールに作成されたブロック（favoriteブロック、クエスチョンブロック、ランキングブロック、Yes or No ブロックブロック、テキストブロック）が1つもないよ、、、:cry: \n 他の社員にもっとブロックを作成してもらえるように頼んでみよう！:hamster:"
        access_token.post("api/chat.postMessage?channel=#{user.uid}&text=#{ERB::Util.url_encode(text)}&pretty=1").parsed
      end
    end
  end
end
