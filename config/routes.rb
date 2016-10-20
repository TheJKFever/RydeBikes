Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # root to: 'angular#index'
  root to: 'home#index'
  
  get 'bikes' => 'bikes#index', as: :home
  resources :bikes
  # post '/bikes/reserve/:id' => 'bikes#reserve'
  # post '/bikes/return/:id' => 'bikes#return'

  # OAuth
  get '/users/auth/:provider/callback' => 'authentication#create', via: [:get, :post]
  get '/auth/:provider/signout' => 'authentication#destroy', via: [:get, :post]

  get 'users/:id/basic_profile', to: 'profile#edit_basic', as: 'edit_basic_profile'
  get 'users/:id/profile', to: 'profile#edit', as: 'edit_profile'
  get 'bikes/tutorial', to: 'bikes#tutorial', as: 'first_login'

  namespace :api, defaults: { format: 'json' } do
    get  '/bikes'             => 'bikes#index' 
    post '/bikes/reserve/:id' => 'bikes#reserve'
    post '/bikes/return/:id'  => 'bikes#return'

    get  'account/payments/client_token' => 'payments#client_token'
    get  'account/payments' => 'payments#index', as: 'payments'
    get  'account/payments/new' => 'payments#new', as: 'new_payment'
    post 'account/payments' => 'payments#create'
    # TODO: add edit/update/delete here for removing cc etc.

    get '/account/history' => 'transactions#index'
    get '/account/history/:id' => 'transactions#show'

    devise_scope :user do
      get  'sign_in', to: 'devise/sessions#new', as: 'new_user_session'
      post 'sign_in', to: 'devise/sessions#create', as: 'user_session'
      get  'sign_up', to: 'devise/registrations#new', as: 'new_user_registration'
      post 'sign_up', to: 'devise/registrations#create', as: 'user_registration'
    end

    post 'help' => 'api#help', as: 'help'
    get 'bikes/:id/pulse' => 'bikes#pulse'
  end

  scope :admin do
    get '/dashboard' => 'admin#dashboard', as: 'admin_dashboard'
    post '/bikes/release/:id' => 'admin#release', as: 'admin_release_bike'
  end
end
