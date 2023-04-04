Rails.application.routes.draw do
  root "sessions#new"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :users
  resources :orders, except: %i[destroy] do
    collection do
      get :schedules
    end
  end
  resources :bookings, only: %i[new create update]
  
  post 'cart/add'
  post 'cart/remove'
  get 'checkout', to: "checkout#index"
  post 'payments/cash'
  get 'payments/card'
  post 'payments/pay'
  get 'success', to: "success#index"
  get 'history', to: "orders#history"

  
  
  resources :categories do
    resources :services
    resources :time_slots
  end
end
