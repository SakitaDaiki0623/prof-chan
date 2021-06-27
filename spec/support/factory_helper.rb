module FactoryHelper
  def create_real_team_with_users(users_count: 3)
    FactoryBot.create(:team, :real_team) do |team|
      FactoryBot.create_list(:user, users_count, team: team)
    end
  end

  def create_normal_team_with_users(users_count: 3)
    FactoryBot.create(:team) do |team|
      FactoryBot.create_list(:user, users_count, team: team)
    end
  end
end