Rails.application.routes.draw do
  devise_for :users #, :only => :omniauth_callbacks

  # root to: 'angular#index'
  root to: 'home#index'
  
  get 'bikes' => 'bikes#index', defaults: {format: 'json'}, as: :home
  resources :bikes, defaults: {format: 'json'} 
  # post '/bikes/reserve/:id' => 'bikes#reserve'
  # post '/bikes/return/:id' => 'bikes#return'

  # OAuth
  get '/users/auth/:provider/callback' => 'authentication#create', via: [:get, :post]
  get '/auth/:provider/signout' => 'authentication#destroy', via: [:get, :post]

  namespace :api, defaults: { format: 'json' } do
    get  '/bikes'             => 'bikes#index' 
    post '/bikes/reserve' => 'bikes#reserve'
    post '/bikes/return'  => 'bikes#return'
    # post '/bikes/interest' => 'bikes#interest'
    # resources :bikes
    # resources :rides
    devise_scope :user do
      get  'sign_in',     to: 'devise/sessions#new', as: 'new_user_session'
      post 'sign_in',     to: 'devise/sessions#create', as: 'user_session'
      delete 'sign_out',  to: 'devise/sessions#destroy', as: 'destroy_user_session'
      get 'sign_up',      to: 'devise/registrations#new', as: 'new_user_registration'
      post 'sign_up',     to: 'devise/registrations#create', as: 'user_registration'
    end

    get 'bikes/:id/pulse' => 'bikes#pulse'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
