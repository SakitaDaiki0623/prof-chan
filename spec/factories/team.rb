FactoryBot.define do
  factory :team do
    sequence(:name, 'team_1')
    sequence(:domain, 'domain_1')
    workspace_id { rand(10 ** 19).to_s }
    share_channel_id { rand(10 ** 19).to_s }
    share_channel_name { "プロフちゃんスペース" }
    image { ENV['TEAM_IMAGE'] }
    share_right { 0 }

    trait :normal_team do
      workspace_id { "A123B123C123" }
    end

    trait :real_team do
      workspace_id { ENV['TEAM_ID']}
    end
  end
end