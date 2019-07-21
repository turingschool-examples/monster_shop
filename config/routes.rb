Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # => root
  get '/', to: 'welcome#index', as: :root

  # => merchants
  resources :merchants do
    resources :items, only: [:index, :new, :create]
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
  resources :orders, only: [:new, :destroy]

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
  get '/merchant/orders/:id', to: 'merchant/orders#show', as: :merchant_orders
  patch '/merchant/orders/:order_id/items/:id', to: 'merchant/items#fulfill', as: :fulfill

  # => admin
  get '/admin', to: 'admin/dashboard#show', as: :admin_dashboard
  get '/admin/merchants/:id', to: 'admin/merchants#show', as: :admin_merchant_show
  get '/admin/merchants', to: 'admin/merchants#index', as: :admin_merchant_index
  get '/admin/users', to: 'admin/users#index', as: :admin_user_index
  get '/admin/users/:id', to: 'admin/users#show', as: :admin_user_show
  patch '/admin/merchants/:id/enable', to: 'admin/merchants#enable', as: :enable_merchant
  patch '/admin/merchants/:id/disable', to: 'admin/merchants#disable', as: :disable_merchant
  patch '/admin/merchants/:merchant_id/items/active', to: 'admin/merchants#enable', as: :activate_merchant_items

  # => user registration & logging in
  get '/register', to: 'users#new', as: :register
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'

  namespace :dashboard do
    resources :items
    post "/items/deactivate", to: "/dashboard/items#deactivate"
    post "/items/activate", to: "/dashboard/items#activate"
  end

  # => dashboard
  scope :dashboard, as: :dashboard do
    resources :orders, only: :show
  end

  get '*path', to: 'welcome#error404'
end
