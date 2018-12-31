Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users, controllers: { registrations: "registrations" }

  resources :quests
  resources :locations
  resources :campaigns
  resources :links, only: [:new, :create, :destroy]
  resources :notes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
