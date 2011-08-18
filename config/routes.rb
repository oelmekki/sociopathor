Rails.application.routes.draw do
    match 'logout'        => 'user_sessions#destroy', :as => :logout
    match 'login'         => 'user_sessions#new', :as => :login
    match 'authenticate'  => 'user_sessions#create', :as => :authenticate, :via => :post
    match 'check-auth'    => 'users#check_auth', :via => :get
    match 'connect'       => 'users#update', :as => :connect

    resource :user_session
    resources :users
end
