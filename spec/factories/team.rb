# == Schema Information
#
# Table name: teams
#
#  id                 :bigint           not null, primary key
#  name               :string(255)      not null
#  image              :string(255)      not null
#  workspace_id       :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# Indexes
#
#  index_users_on_workspace_id          (workspace_id)

# spec/factories/team.rb
FactoryBot.define do
  factory :team do
    sequence(:name, 'team_1')
    workspace_id { rand(10 ** 19).to_s }
    image { ENV['TEAM_IMAGE'] }

    trait :real_team do
      workspace_id { ENV['TEAM_ID']}
    end
  end
end