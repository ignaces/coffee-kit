Rails.application.routes.draw do

  # application

  root 'pages#landing'
  
  resource :users 
  resources :password_resets
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :products
  get 'store' => 'products#index'

  resource :subscription do
    get 'month/:date' => 'subscriptions#show_month', as: 'month'
    put 'month/:date/select_beans' => 'subscriptions#select_month_beans', as: 'select_month_beans'
  end

  resources :shipping_addresses do 
    collection do 
      get 'load_communes'
    end
  end

  resources :orders do
    member do 
      get 'shipping'
      get 'coffee'
      get 'pricing'
      get 'checkout'
    end 
    collection do 
      get 'cart'
      get 'apply_discount'
      get 'success'
      get 'khipu_success'
      post 'add_to_cart'
      post 'add_subscription'
      post 'update_pricing'
      post 'update_coffee'
      post 'update_shipping'
      delete 'remove_from_cart'
      delete 'remove_subscription_from_cart'
      post 'update_product_quantity'
      post 'pay_with_khipu'
      post 'pay_with_paypal'
      post 'redeem_code'
    end
  end
 
  get 'signup' => 'users#new'
  get 'signin' => 'sessions#new'
  delete 'signout' =>'sessions#destroy'

  get 'origenes' => 'pages#landing_coffee'
  get 'terms' => 'pages#terms'

  # payments 

  namespace :payments do 
    post 'khipu_verification' => 'khipu#verify'
    get 'paypal_verification' => 'paypal#verify'
  end

  # admin

  namespace :barista do 
    root 'dashboard#index'
    resources :users
    resources :products
    resources :coffee_beans
    resources :subscription_plans do 
      resources :subscription_plan_entries
    end

    resources :cities do 
      member do 
        put 'update_commune'
      end
    end

    resources :orders 
    resources :shipments do 
      member do 
        patch 'update_status'
      end
    end

    get 'ember'
  end

  # api

  namespace :api do 
    get 'status' => 'operations#status'
    resources :orders do 
      collection do 
        get 'total_revenue'
      end
    end
  end
end
