Rails.application.routes.draw do
  resources :order_statusezs
  resources :orderzs
  resources :product_orderzs
  resources :productzs
  resources :customerzs
  resources :addressezs
  resources :uzers
  resources :reztaurants
  resources :staffs
  devise_for :users, controllers: {
    sessions: 'employee_sessions'
  }
 
  namespace :api do
    resources :orders, only: [:index, :create]
    put "orders/:id/status", to: "orders#set_status" 
    post "orders/:id/status", to: "orders#set_status"  
    post "orders/:id/rating", to: "orders#set_rating"
    post "login", to: "auth#index"
    get "restaurants", to: "restaurants#index"
    get "products", to: "products#index"
    get "orders", to: "orders#index"
    post "orders", to: "orders#create"
    get "account", to: "account#index"
    post "account", to: "account#updated"
  end
  

  root to: "home#index"
end
