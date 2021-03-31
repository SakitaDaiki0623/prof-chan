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
#  slack_credential_token  :string(255)     not null
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
    team_id { rand(10 ** 19).to_s }
    uid     { rand(10 ** 19).to_s }
    slack_credential_token { rand(10 ** 19).to_s }
    provider { 'slack' }
    password { 'password' }
    image { 'https://avatars.slack-edge.com/2021-03-08/1825255374918_7955fb79fef81b734c2a_34.jpg' }
  end
end
