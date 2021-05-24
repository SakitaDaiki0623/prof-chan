# config/routes.rb
Rails.application.routes.draw do

  namespace :admin do
      resources :users
      resources :ranking_block_likes
      resources :text_block_likes
      resources :profile_blocks
      resources :favorite_block_likes
      resources :yes_or_no_blocks
      resources :ranking_blocks
      resources :my_favorite_blocks
      resources :favorite_blocks
      resources :address_blocks
      resources :teams
      resources :text_blocks
      resources :profiles
      resources :question_block_likes
      resources :question_blocks
      resources :yes_or_no_block_likes
      resources :yes_or_no_items
      resources :question_items

      # active hash
      resources :categories
      resources :prefectures

      # ADMIN_ROOT_PATH
      root to: "users#index"
    end

  # ROOT_PATH
  root to: 'home#index'

  get 'top', to: 'profiles#top'

  # authetication
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    # guest login
    # 参考: https://qiita.com/take18k_tech/items/35f9b5883f5be4c6e104
    post '/users/guest_sign_in', to: 'users/sessions#new_guest'
  end


  # redirect path after authentication
  resources :profiles,  only: %i[new index]

  # API
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :profiles,       only: %i[index create show update] do
        collection do
          get 'recently_joined_user_profiles'
          get 'birthday_user_profiles'
        end
      end
      resources :users,          only: %i[index show new] do
        collection do
          get 'get_current_user'
        end
      end
      resources :teams,          only: %i[show]

      # プロフブロック
      resources :profile_blocks,     only: %i[index show]
      resources :favorite_blocks,        only: %i[index create show update destroy] do
        collection do
          get  'random_current_user_likes_blocks'
          get  'popular_blocks'
        end
      end
      resources :text_blocks,        only: %i[index create show update destroy] do
        collection do
          get  'random_current_user_likes_blocks'
          post 'post_to_slack_after_create'
          get  'popular_blocks'
        end
      end
      resources :question_blocks,    only: %i[index create show update destroy] do
        collection do
          get  'random_current_user_likes_blocks'
          post 'post_to_slack_after_create'
          get  'popular_blocks'
        end
      end
      resources :question_items,     only: %i[index create update destroy]
      resources :ranking_blocks,     only: %i[index create show update destroy] do
        collection do
          get  'random_current_user_likes_blocks'
          post 'post_to_slack_after_create'
          get  'popular_blocks'
        end
      end
      resources :yes_or_no_blocks,   only: %i[index create show update destroy] do
        collection do
          get  'random_current_user_likes_blocks'
          post 'post_to_slack_after_create'
          get  'popular_blocks'
        end
      end
      resources :yes_or_no_items,    only: %i[index create update destroy]
      resources :my_favorite_blocks, only: %i[index update]
      resources :address_blocks,     only: %i[index update]

      # 各ブロックのいいね機能
      namespace :likes do
        resources :text_block_likes,      only: [:index, :create, :destroy]
        resources :question_block_likes,  only: [:index, :create, :destroy]
        resources :ranking_block_likes,   only: [:index, :create, :destroy]
        resources :yes_or_no_block_likes, only: [:index, :create, :destroy]
        resources :favorite_block_likes,  only: [:index, :create, :destroy]
      end
    end
  end

  get '*path', to: 'profiles#top'
end
