# config/routes.rb
Rails.application.routes.draw do

  # ROOT_PATH
  root to: 'home#index'

  # authetication
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_scope :user do
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  # redirect path after authentication
  resources :profiles,  only: %i[new index]

  # API
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :profiles,       only: %i[index create show update]
      resources :users,          only: %i[index show new] do
        collection do
          get 'get_current_user'
        end
      end
      resources :teams,          only: %i[show]

      # プロフブロック
      resources :profile_blocks,     only: %i[index show]
      resources :text_blocks,        only: %i[index create show update destroy]
      resources :question_blocks,    only: %i[index create show update destroy] do
        collection do
          post 'post_to_slack_after_create'
        end
      end
      resources :question_items,     only: %i[index create update destroy]
      resources :ranking_blocks,     only: %i[index create show update destroy]
      resources :yes_or_no_blocks,   only: %i[index create show update destroy] do
        collection do
          post 'post_to_slack_after_create'
        end
      end
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

  get '*path', to: 'profiles#index'
end
