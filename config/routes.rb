Rails.application.routes.draw do
  root 'welcome#index'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :merchants do
    resources :items, only: [:index, :new, :create, :update]
  end

  resources :items, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]

  get '/cart', to: 'cart#show'
	post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'

  get '/register/new', to: 'users#new', as: :new_user
  resources :users, only: [:create, :show, :edit, :update] do
  	resources :orders, only: [:create, :show]
  end

  get '/profile', to: 'users#show', as: :profile
  get '/profile/orders', to: 'orders#index', as: :profile_orders
  get '/profile/order/:id', to: 'orders#show', as: :profile_order
  patch '/profile/order/:id', to: 'orders#update', as: :cancel_order
  get '/edit_password', to: 'users#edit_password', as: :edit_password
  patch '/profile', to: 'users#update_password', as: :update_password
  get '/admin', to: 'admin/users#dashboard', as: :admin_dashboard
  get '/merchant', to: 'merchant_admins/users#dashboard', as: :merchant_dashboard

	patch "/merchant_admins/items/:merchant_id/:item_id", to: "merchant_admins/items#activate", as: :activate_items

  namespace :merchant_admins do
    resources :items, only: [:new, :create, :edit, :update, :destroy]
		resources :users
  end
  namespace :merchant_admins do
    resources :items, only: [:update, :new, :create]
    resources :orders, only: [:show, :update]
  end
  patch '/admin/orders/:id', to: 'admin/orders#update', as: :ship_order

  namespace :admin do
    resources :users
    # resources :orders, only: [:update]
  end


	get '/merchant/items', to: 'merchant_admins/items#index'

  get '/admin/merchants/:id', to: 'admin/merchants#dashboard', as: :admin_merchant_dashboard
  patch '/admin/merchant/:id/disable', to: 'admin/merchants#disable', as: :admin_merchant_disable
  patch '/admin/merchant/:id/enable', to: 'admin/merchants#enable', as: :admin_merchant_enable
end
