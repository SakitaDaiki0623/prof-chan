# config/initializers/slack_ruby_client.rb
Slack.configure do |config|
  config.token = ENV['BOT_USER_ACCESS_TOKEN']
end