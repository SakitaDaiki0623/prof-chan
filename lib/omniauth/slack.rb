require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Slack < OmniAuth::Strategies::OAuth2
      option :client_options, site: 'https://slack.com', authorize_url: 'oauth/v2/authorize', token_url: 'api/oauth.v2.access', raise_errors: false
      option :authorize_options, %i[scope user_scope]

      uid do
        "#{raw_info.dig('authed_user', 'id')}-#{raw_info.dig('team', 'id')}"
      end

      info do
        raw_info
      end

      def raw_info
        @raw_info ||= access_token.params
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end