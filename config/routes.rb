# config/routes.rb
Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    omniauth_callbacks: 'overrides/omniauth_callbacks'
  }

  # ROOT_PATH
  root to: 'home#index'

  # authetication ルートが被ってしまうためコメントアウト
  # devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  # devise_scope :user do
  #   delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  # end

  # API
  namespace :api, {format: 'json'} do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        omniauth_callbacks: 'api/v1/auth/omniauth_callbacks'
      }
      resources :profiles,       only: %i[index create show update]
      resources :users,          only: %i[index show new]
      resources :teams,          only: %i[show]

      # プロフブロック
      resources :profile_blocks,     only: %i[index show]
      resources :text_blocks,        only: %i[index create show update destroy]
      resources :question_blocks,    only: %i[index create show update destroy]
      resources :question_items,     only: %i[index create update destroy]
      resources :ranking_blocks,     only: %i[index create show update destroy]
      resources :yes_or_no_blocks,   only: %i[index create show update destroy]
      resources :yes_or_no_items,    only: %i[index create update destroy]
      resources :my_favorite_blocks, only: %i[index update]
      resources :address_blocks,     only: %i[index update]

      # 各ブロックのいいね機能
      resources :text_block_likes,      only: [:index, :create, :destroy]
      resources :question_block_likes,  only: [:index, :create, :destroy]
      resources :ranking_block_likes,   only: [:index, :create, :destroy]
      resources :yes_or_no_block_likes, only: [:index, :create, :destroy]
    end
  end

  # TODO slackトークン認証完了後コメントイン
  # get '*path', to: 'home#index' <= 404ページが表示されないようにコメントアウトしておく
end
