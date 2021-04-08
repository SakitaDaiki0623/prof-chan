# spec/factories/team.rb
FactoryBot.define do
  factory :team do
    sequence(:name, 'team_1')
    workspace_id { rand(10 ** 19).to_s }
    image { 'https://i.gyazo.com/8d2552b2b503370172c05eb893204f18.png' }

    trait :real_team do
      workspace_id { 'T01QG6RRLUT' }
      image { 'https://avatars.slack-edge.com/2021-03-08/1825255374918_7955fb79fef81b734c2a_34.jpg' }
    end
  end
end