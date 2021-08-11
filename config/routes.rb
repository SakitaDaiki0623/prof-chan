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
    resources :contacts
    resources :authentications

    root to: "users#index"
  end

  root to: 'home#index'
  get 'top', to: 'profiles#top'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    post '/users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :profiles,  only: %i[new index]

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :profiles,       only: %i[index create show update] do
        collection do
          get 'recently_joined_user_profiles'
          get 'birthday_user_profiles'
        end
      end

      resources :users,          only: %i[index show new update] do
        collection do
          get   'get_current_user'
          # share right
          patch 'update_question_share_right'
          patch 'update_ranking_share_right'
          patch 'update_yes_or_no_share_right'
          patch 'update_text_share_right'

          # recommended
          get  'recommended_users'
        end
      end

      resources :teams,          only: %i[show]

      resources :profile_blocks,     only: %i[index show]
      resources :favorite_blocks,        only: %i[index create show update destroy] do
        collection do
          get  'random_current_user_likes_blocks'
          get  'popular_blocks'
          get  'recommended_topic_block'
        end
      end
      resources :text_blocks,        only: %i[index create show update destroy] do
        collection do
          get  'random_current_user_likes_blocks'
          post 'post_to_slack_after_create'
          get  'popular_blocks'
          get  'recommended_topic_block'
        end
      end
      resources :question_blocks,    only: %i[index create show update destroy] do
        collection do
          get  'random_current_user_likes_blocks'
          post 'post_to_slack_after_create'
          get  'popular_blocks'
          get  'recommended_topic_block'
        end
      end
      resources :question_items,     only: %i[index create update destroy]
      resources :ranking_blocks,     only: %i[index create show update destroy] do
        collection do
          get  'random_current_user_likes_blocks'
          post 'post_to_slack_after_create'
          get  'popular_blocks'
          get  'recommended_topic_block'
        end
      end
      resources :yes_or_no_blocks,   only: %i[index create show update destroy] do
        collection do
          get  'random_current_user_likes_blocks'
          post 'post_to_slack_after_create'
          get  'popular_blocks'
          get  'recommended_topic_block'
        end
      end
      resources :yes_or_no_items,    only: %i[index create update destroy]
      resources :address_blocks,     only: %i[index update]

      namespace :likes do
        resources :text_block_likes,      only: [:index, :create, :destroy]
        resources :question_block_likes,  only: [:index, :create, :destroy]
        resources :ranking_block_likes,   only: [:index, :create, :destroy]
        resources :yes_or_no_block_likes, only: [:index, :create, :destroy]
        resources :favorite_block_likes,  only: [:index, :create, :destroy]
      end
    end
  end

  namespace :slack do
    namespace :settings do
      post 'activate_share_right',   to: 'share#activate'
      post 'deactivate_share_right', to: 'share#deactivate'
    end
    namespace :post do
      post 'random_block', to: 'direct_post#random_block'
      post 'help', to: 'direct_post#help'
    end
    post 'events', to: 'app_home_opened#respond'
  end

  get 'agreement', to: 'home#agreement'
  get 'terms', to: 'home#terms'
  get 'privacy', to: 'home#privacy'

  resources :contacts, only: [:new, :create]
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  post 'contacts/back', to: 'contacts#back', as: 'back'
  get 'contacts/done', to: 'contacts#done', as: 'done'

  get '*path', to: 'profiles#top'
end
