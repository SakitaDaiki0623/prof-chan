# config/routes.rb
Rails.application.routes.draw do

  # ROOT_PATH
  root to: 'home#index'

  # authetication (login/logout)
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_scope :user do
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  # redirect path after authentication
  resources :profiles,  only: %i[new index]

  # API
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :profiles, only: %i[index create show]
      resources :users,    only: %i[index show new]
      resources :teams,    only: %i[show]
    end
  end

  get '*path', to: 'home#index'
end
