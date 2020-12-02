Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :products
  resource :cart
  resources :cart_items, only: [:destroy]
  post "/add_item_cart/:id", to: "carts#add_to_cart", as: "add_to_cart"
  patch "/update_amount/:id", to: "carts#update_amount", as: "update_amount"
  # delete "/delete_cart_item/:id", to: "carts#destroy", as: "delete_cart_item"

  post "/increase_amount/:id", to: "carts#increase_amount", as: "increase_amount"
  post "/decrease_amount/:id", to: "carts#decrease_amount", as: "decrease_amount"


end
