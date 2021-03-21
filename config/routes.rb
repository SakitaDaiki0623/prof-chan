# config/routes.rb
Rails.application.routes.draw do
  #TODO: 不具合が出てくる可能性あり
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_scope :user do
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end
  root to: 'home#index'
  resources :users,  only: %i[new create]
  resources :profiles
end
