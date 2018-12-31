Rails.application.routes.draw do
  
  # different roots for authenticated users
  authenticated :user do
    root to: 'static_pages#user_home', as: :authenticated_root
  end
  root 'static_pages#home'

  devise_for :users, controllers: { registrations: "registrations" }

  # resources
  resources :quests
  resources :locations
  resources :campaigns
  resources :links, only: [:new, :create, :destroy]
  resources :notes
end
