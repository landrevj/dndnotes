Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # different roots for authenticated users
  authenticated :user do
    root to: 'static_pages#home', as: :authenticated_root
  end
  root to: redirect('/login')

  # custom routes for devise
  devise_for :users, controllers: { registrations: "registrations" }, skip: [:sessions]
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get :search, controller: :search, defaults: {format: 'json'}

  # resources
  resources :quests
  resources :locations
  resources :campaigns
  resources :links, only: [:new, :create, :destroy]
  resources :notes
end
