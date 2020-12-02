Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resource :dashboard, only: [:show] do
    member do
      get 'profile'
      get 'messages'
    end
  end

  resources :products
  resource :cart
  post "/add_item_cart/:id", to: "carts#add_to_cart", as: "add_to_cart"
end
