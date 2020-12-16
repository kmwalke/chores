Rails.application.routes.draw do
  require 'sidekiq/web'

  root to: 'home#index'

  resources :features
  resources :permissions
  resources :rewards
  resources :roles
  resources :tasks
  resources :users

  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # mount Sidekiq::Web => '/sidekiq'
end
