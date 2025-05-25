Rails.application.routes.draw do
  # Authentication routes
  devise_for :users

  # Public routes
  root 'pages#home'
  
  get 'about', to: 'pages#about'

  # Product routes
  resources :products, only: [:index, :show] do
    collection do
      get 'search'
    end
  end

  # Admin routes
  namespace :admin do
    root 'dashboard#index'  # This will create admin_root_path
    resources :products
    resources :users
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
