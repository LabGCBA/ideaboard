Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'ideas#index'
  post '/ideas/:id' => 'ideas#vote', as: 'vote_idea'
  devise_for :personas, :path => '', path_names: {sign_in: 'login', sign_out: 'logout'}, controllers: {omniauth_callbacks: "callbacks"}
  resources :personas, :direcciones, :subsecretarias, :estados, :comentarios
  
  resources :ideas do
    member do
      get :estados
      get :comentarios
    end
  end
  
  # resources :sessions, only: [:new, :create, :destroy]
  # get '/auth/:provider/callback', to: 'sessions#create'
  
  get '/baid/login' => 'baid#login', as: 'baid_login'
  get '/baid/callback' => 'baid#callback', as: 'baid_callback'


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
