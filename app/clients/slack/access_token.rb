module Slack
  class AccessToken
    def self.set_access_token(hash_token)
      OmniAuth::Slack.build_access_token(ENV['SLACK_CLIENT_ID'], ENV['SLACK_CLIENT_SECRET'], hash_token)
    end
  end
end
