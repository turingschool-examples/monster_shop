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

  get '/register', to: 'users#new', as: :register

  post '/users', to: 'users#create', as: :users
  get '/users/:id', to: 'users#show', as: :user
  get '/users/:id/edit', to: 'users#edit', as: :edit_user 
  patch '/users/:id', to: 'users#update', as: :update_user

  get '/profile', to: 'users#show', as: :profile

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
