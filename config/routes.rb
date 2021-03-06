Rails.application.routes.draw do

    namespace :admin do
        resources :personas
        resources :categoria
        resources :comentarios
        resources :direcciones
        resources :estados
        resources :ideas
        resources :roles
        resources :subsecretarias
        resources :votes

        root to: "personas#index"
    end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

    root 'ideas#index'
    get '/tv' => 'ideas#tv'
    post '/ideas/:id' => 'ideas#vote', as: 'vote_idea'
    post '/ideas/:id/etapa/:etapa_id' => 'ideas#update_etapa', as: 'update_etapa'

    # get '/baid/callback' => redirect(path: '/expresometro/personas/auth/openid_connect/callback')

    resources :direcciones, :subsecretarias, :estados, :comentarios

    resources :ideas do
        member do
            get :estados
            get :comentarios
        end
    end

    devise_for :personas, controllers: {
        omniauth_callbacks: 'personas/omniauth_callbacks',
        sessions: 'personas/sessions',
        registrations: 'personas/registrations',
        passwords: 'personas/passwords'
    }

    devise_scope :persona do
    get '/baid/login' => 'callbacks#baid_login', as: 'baid_login'
    get '/baid/callback' => 'callbacks#baid_callback', as: 'baid_callback'
end


  # resources :sessions, only: [:new, :create, :destroy]
  # get '/auth/:provider/callback', to: 'sessions#create'
  # get '/baid/login' => 'baid#login', as: 'baid_login'

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
