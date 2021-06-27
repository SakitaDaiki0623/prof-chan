FactoryBot.define do
  factory :user do
    sequence(:name, 'user_1')
    sequence(:email)   { |n| "sample#{n}@example.com" }
    uid     { rand(10 ** 19).to_s }
    provider { 'email' }
    password { 'password' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/images/prof_normal.png')) }
    agreement { true }
    association :team

    trait :slack do
      provider { 'slack' }
    end

    trait :real_workspace_id do
      image { ENV['TEAM_IMAGE'] }
      association :team, workspace_id: ENV['TEAM_ID']
    end

    trait :admin do
      name { "プロフちゃん管理" }
      email { ENV["ADMIN_MAIL"] }
      password { ENV["ADMIN_PASSWORD"] }
      password_confirmation { ENV["ADMIN_PASSWORD"] }
      uid { ENV["ADMIN_UID"] }
      role {0 }
      provider { 'email' }
    end

    after(:create) do |user|
      create(:profile, user: user)
      create(:profile_block, user: user)
    end
  end
end

