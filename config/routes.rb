Rails.application.routes.draw do
  require 'sidekiq/web'

  root to: 'home#index'
  patch 'complete/:id', to: 'home#complete', as: 'complete_task_instance'

  get 'current_user/edit', as: 'edit_current_user'
  patch 'current_user/update', as: 'update_current_user'
  delete 'current_user/delete', as: 'delete_current_user'
  delete 'current_user/destroy', as: 'destroy_current_user'
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
