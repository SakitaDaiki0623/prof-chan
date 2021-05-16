require 'factory_bot'
require 'faker'

# create real team workspace and users
FactoryBot.create(:team, :real_team) do |team|
  FactoryBot.create_list(:user, 10, team: team)
  random_five_users = User.all.shuffle.slice(0, 5)
  random_ten_question_blocks = QuestionBlock.all.shuffle.slice(0, 10)
  random_ten_ranking_blocks = RankingBlock.all.shuffle.slice(0, 10)
  random_ten_text_blocks = TextBlock.all.shuffle.slice(0, 10)
  random_ten_yes_or_no_blocks = YesOrNoBlock.all.shuffle.slice(0, 10)
  random_five_users.each do |user|
    random_ten_question_blocks.each do |block|
      FactoryBot.create(:question_block_like, user: user, question_block: block)
    end
    random_ten_ranking_blocks.each do |block|
      FactoryBot.create(:ranking_block_like, user: user, ranking_block: block)
    end
    random_ten_text_blocks.each do |block|
      FactoryBot.create(:text_block_like, user: user, text_block: block)
    end
    random_ten_yes_or_no_blocks.each do |block|
      FactoryBot.create(:yes_or_no_block_like, user: user, yes_or_no_block: block)
    end
  end
end

# create another team workspace and users belonging to it
FactoryBot.create(:team) do |team|
  FactoryBot.create_list(:user, 10, team: team)
end