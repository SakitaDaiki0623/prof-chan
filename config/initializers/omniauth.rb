# config/initializers/omniauth.rb
# 参考: https://github.com/ginjo/omniauth-slack/blob/v2.5.0/README.md
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV['SLACK_CLIENT_ID'], ENV['SLACK_CLIENT_SECRET'], user_scope: 'identity.basic', scope: 'team:read,users:read' # , :provider_ignores_state => true
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'] # 練習用
end

# 参考: https://stackoverflow.com/questions/66009147/no-route-matches-get-auth-twitter-omnia
OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true

# RSpecのモック認証のリダイレクト時にエラーにならないように設定
if Rails.env.test?
  Rails.application.config.middleware.use OmniAuth::Builder do
    on_failure { |env| Users::OmniauthCallbacksController.action(:failure).call(env) }
  end
end
