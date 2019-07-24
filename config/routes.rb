Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # => root
  get '/', to: 'welcome#index', as: :root

  get '/merchants/new', to: 'admin/merchants#new', as: :new_merchant
  post '/merchants', to: 'admin/merchants#create', as: :create_merchant
  get '/merchants/:id', to: 'admin/merchants#edit', as: :edit_merchant
  patch '/merchants/:id', to: 'admin/merchants#update'
  delete 'merchants/:id', to: 'admin/merchants#destroy', as: :delete_merchant

  # => merchants
  resources :merchants, only: [:index, :show] do
    resources :items, only: [:index]
  end

  # => items
  resources :items, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end

  # => reviews
  resources :reviews, only: [:edit, :update, :destroy]

  # => cart
  get '/cart', to: 'cart#show', as: :cart_path
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
  get '/merchant', to: 'merchant/orders#index', as: :merchant_dashboard
  get '/merchant/orders/:id', to: 'merchant/orders#show', as: :merchant_orders
  patch '/merchant/orders/:order_id/items/:id', to: 'merchant/items#fulfill', as: :fulfill

  # => admin
  get '/admin/dashboard', to: 'admin/orders#index', as: :admin_dashboard
  patch '/admin/order/:id', to: 'admin/orders#update', as: :admin_ships_order
  get '/admin/merchants/:id', to: 'admin/merchants#show', as: :admin_merchant_show
  get '/admin/merchants/:id/items', to: 'admin/items#index', as: :admin_merchant_items
  get '/admin/merchants', to: 'admin/merchants#index', as: :admin_merchant_index
  get '/admin/users', to: 'admin/users#index', as: :admin_user_index
  get '/admin/users/:id', to: 'admin/users#show', as: :admin_user_show
  get '/admin/users/:user_id/orders/:order_id', to: 'admin/orders#show', as: :admin_user_order
  patch '/admin/merchants/:id/enable', to: 'admin/merchants#enable', as: :enable_merchant
  patch '/admin/merchants/:id/disable', to: 'admin/merchants#disable', as: :disable_merchant

  # => user registration & logging in
  get '/register', to: 'users#new', as: :register
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'

  get '/dashboard/items', to: 'merchant/items#index', as: :dashboard_items
  get '/dashboard/items/new', to: 'merchant/items#new', as: :new_item
  get '/dashboard/items/:id/edit', to: 'merchant/items#edit', as: :edit_item
  patch '/dashboard/items/:id/edit', to: 'merchant/items#update', as: :update_item
  post '/dashboard/items', to: 'merchant/items#create', as: :create_item
  post '/dashboard/items/deactivate', to: 'merchant/items#deactivate'
  post '/dashboard/items/activate', to: 'merchant/items#activate'
  delete '/dashboard/items/:id/delete', to: 'merchant/items#destroy', as: :delete_item

  # => dashboard
  scope :dashboard, as: :dashboard do
    resources :orders, only: :show
  end

  get '*path', to: 'welcome#error404'
end
