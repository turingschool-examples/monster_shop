Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index', as: :root

  resources :merchants do
    resources :items, only: [:index, :new, :create]
  end

  resources :items, only: [:index, :show, :edit, :update, :destroy] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]

  get '/cart', to: 'cart#show'
  post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'

  resources :orders, only: [:new, :create, :show]

  resources :users, only: [:create, :show, :edit, :update]

  get '/register', to: 'users#new', as: :register
  get '/profile', to: 'users#show', as: :profile
  get '/profile/edit', to: 'users#edit', as: :profile_edit
  patch '/profile/edit', to: 'users#update'

  scope :profile, as: :profile do
    resources :orders, only: [:index, :show]
  end

  get '/merchant', to: 'merchant/dashboard#show', as: :merchant_dashboard
  get '/admin', to: 'admin/dashboard#show', as: :admin_dashboard

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  namespace :admin do
    resources :categories, only: [:index]
  end

  scope :dashboard, as: :dashboard do
    resources :orders, only: :show
  end

end
