# config/initializers/middleware.rb
require 'omniauth-slack'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, Rails.application.credentials.dig(:slack, :client_id), Rails.application.credentials.dig(:slack, :client_secret), scope: 'identity.basic', name: :sign_in_with_slack, provider_ignores_state: true
  provider :slack, Rails.application.credentials.dig(:slack, :client_id), Rails.application.credentials.dig(:slack, :client_secret), scope: 'team:read,users:read,identify,bot', provider_ignores_state: true
end