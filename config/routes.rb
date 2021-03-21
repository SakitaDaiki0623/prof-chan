# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'
  resources :users,  only: %i[new create]
  resources :profiles

  # oauthログイン用のルーティング
  # post "oauth/callback", to: "oauths#callback"
  # get "oauth/callback", to: "oauths#callback"
  # get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider

  # omniauthのルーティング
  # get 'auth/slack/callback', to: 'auth#callback'
end
