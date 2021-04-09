require 'factory_bot'
require 'faker'

# create real team workspace and users
FactoryBot.create(:team, :real_team) do |team|
  FactoryBot.create_list(:user, 10, team: team)
end

# create another team workspace and users belonging to it
FactoryBot.create(:team) do |team|
  FactoryBot.create_list(:user, 10, team: team)
end