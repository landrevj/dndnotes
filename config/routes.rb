Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # different roots for authenticated users
  authenticated :user do
    root to: 'workspaces#active', as: :authenticated_root
  end
  root to: redirect('/login')

  # custom routes for devise
  devise_for :users, controllers: { registrations: 'registrations' }, skip: [:sessions]
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get :search, controller: :search, defaults: { format: 'json' }

  # resources
  resources :workspaces, only: [:edit, :update, :create, :destroy] do
    resources :categories, except: [:index] do
      resources :notes, except: [:index]
    end
  end

  resource :workspace, only: [:active] do
    get :active, on: :member
  end

  # resources :links
  resources :links, only: [:update, :create, :destroy]
end
