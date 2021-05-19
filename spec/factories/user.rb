# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  name               :string(255)      default(""), not null
#  email              :string(255)      not null, unique: true
#  provider           :string(255)      default(""), not null
#  uid                :string(255)      not null, unique: true
#  image              :string(255)
#  team_id            :string(255)      not null
#  encrypted_password :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :string(255)
#  remember_created_at     :string(255)
#
# Indexes
#
#  index_users_on_email                    (email)
#  index_users_on_reset_password_token     (reset_password_token)

# spec/factories/user.rb
FactoryBot.define do
  factory :user do
    sequence(:name, 'user_1')
    sequence(:email)   { |n| "sample#{n}@example.com" }
    uid     { rand(10 ** 19).to_s }
    provider { 'slack' }
    password { 'password' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/images/prof_normal.png')) }
    association :team

    trait :real_workspace_id do
      image { ENV['TEAM_IMAGE'] }
      association :team, workspace_id: ENV['TEAM_ID']
    end

    after(:create) do |user|
      create(:profile, user: user)
      create(:profile_block, user: user)
    end
  end
end

