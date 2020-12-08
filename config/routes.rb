Rails.application.routes.draw do
  get 'stores/show'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resource :dashboard, only: [:show] do
    member do
      get 'profile'
      get 'orders'
      get 'wishlist'
    end
  end

  post "/add_item_wishlist/:id", to: "products#add_to_wishlist", as: "add_to_wishlist"
  delete "/delete_from_wishlist/:id", to: "products#delete_from_wishlist", as: "delete_from_wishlist"
  delete "/delete_in_wishlist/:id", to: "products#destroy", as: "delete_in_wishlist"
  # delete "/dashboard/wishlist/:id", to: "products#destroy", as: "delete_in_wishlist"

  resources :stores, only: [:show], as: 'store' do
    member do
      post 'chat', to: 'chatrooms#show'
      post 'chatrooms', to: "chatrooms#create"
    end
  end

  resources :products do
    resources :reviews, only: [ :new, :create ]
  end

  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end

  resources :reviews, except: [ :new, :create]

  resources :chatrooms, only: [:show, :index] do
    resources :messages, only: :create
  end

  resource :cart
  resources :cart_items, only: [:destroy]
  post "/add_item_cart/:id", to: "carts#add_to_cart", as: "add_to_cart"
  patch "/update_amount/:id", to: "carts#update_amount", as: "update_amount"
  # delete "/delete_cart_item/:id", to: "carts#destroy", as: "delete_cart_item"

  post "/increase_amount/:id", to: "carts#increase_amount", as: "increase_amount"
  post "/decrease_amount/:id", to: "carts#decrease_amount", as: "decrease_amount"


end
