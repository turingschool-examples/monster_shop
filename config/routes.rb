Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # => root
  get '/', to: 'welcome#index', as: :root

  # => merchants
  resources :merchants do
    resources :items, only: [:index, :new, :create]
  end

  namespace :dashboard do
    resources :items
  end

  # => items
  resources :items, only: [:index, :show, :edit, :update, :destroy] do
    resources :reviews, only: [:new, :create]
  end

  # => reviews
  resources :reviews, only: [:edit, :update, :destroy]

  # => cart
  get '/cart', to: 'cart#show'
  post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'

  # => orders
  resources :orders, only: [:new]

  # => users
  resources :users, only: [:create, :show, :edit, :update]

  # => profile
  get '/profile', to: 'users#show', as: :profile
  get '/profile/edit', to: 'users#edit', as: :profile_edit
  patch '/profile/edit', to: 'users#update'

  # => pull up past & current orders for a user
  scope :profile, as: :profile do
    resources :orders, only: [:index, :show, :create]
  end

  # => merchant
  get '/merchant', to: 'merchant/dashboard#show', as: :merchant_dashboard

  # => admin
  get '/admin', to: 'admin/dashboard#show', as: :admin_dashboard
  get '/admin/merchants/:id', to: 'admin/merchants#show', as: :admin_merchant_show
  get '/admin/merchants', to: 'admin/merchants#index', as: :admin_merchant_index
  patch '/admin/merchants/:id/enable', to: 'admin/merchants#enable', as: :enable_merchant
  patch '/admin/merchants/:id/disable', to: 'admin/merchants#disable', as: :disable_merchant

  # => user registration & logging in
  get '/register', to: 'users#new', as: :register
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'

  # => dashboard
  scope :dashboard, as: :dashboard do
    resources :orders, only: :show
  end

  get '*path', to: 'welcome#error404'
end
