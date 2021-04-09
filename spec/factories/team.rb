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