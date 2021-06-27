# require 'factory_bot'
# require 'faker'

# # create another team workspace and users belonging to it
# if Rails.env.development?



#   # create real team workspace and users
#   FactoryBot.create(:team, :normal_team) do |team|
#     FactoryBot.create(:user, :admin, team: team)
#     FactoryBot.create_list(:user, 30, team: team)
#     random_five_users = User.all.shuffle.slice(0, 5)
#     random_ten_question_blocks = QuestionBlock.all.shuffle.slice(0, 10)
#     random_ten_ranking_blocks = RankingBlock.all.shuffle.slice(0, 10)
#     random_ten_text_blocks = TextBlock.all.shuffle.slice(0, 10)
#     random_ten_yes_or_no_blocks = YesOrNoBlock.all.shuffle.slice(0, 10)
#     random_five_users.each do |user|
#       random_ten_question_blocks.each do |block|
#         FactoryBot.create(:question_block_like, user: user, question_block: block)
#       end
#       random_ten_ranking_blocks.each do |block|
#         FactoryBot.create(:ranking_block_like, user: user, ranking_block: block)
#       end
#       random_ten_text_blocks.each do |block|
#         FactoryBot.create(:text_block_like, user: user, text_block: block)
#       end
#       random_ten_yes_or_no_blocks.each do |block|
#         FactoryBot.create(:yes_or_no_block_like, user: user, yes_or_no_block: block)
#       end
#     end
#   end
#   # 管理者の作成

#   FactoryBot.create(:team, :real_team) do |team|
#     FactoryBot.create_list(:user, 30, :slack, team: team)
#   end
# end

if Rails.env.production?
  Team.create!(
    name: 'normal login',
    workspace_id: 'A123B123C123',
    share_channel_id: 'A123B123C123',
    share_channel_name: 'A123B123C123',
    domain: 'A123B123C123',
    image: "https://i.gyazo.com/f0c0826c1358634f1821320e5530f8ec.png"
  )
end
