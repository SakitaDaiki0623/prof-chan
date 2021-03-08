# config/routes.rb
Rails.application.routes.draw do
  root to: 'home#index'
  resources :users,  only: %i[new create]
  resources :profiles

  # sorceryのログイン機能のルーティング-----
  get 'login',     to: 'user_sessions#new'
  post 'login',    to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
