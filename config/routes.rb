Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/auth/redirect_to_discord', to: 'authentication#redirect_to_discord'
  get '/auth/discord/callback', to: 'authentication#discord_callback'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get '/dashboard', to: 'home#dashboard'

  # Events
 # get '/events/new', to: 'events#new', as: 'new_event'
 # get '/events', to: 'events#index', as: 'find_event'
 # post '/events', to: 'events#create'

 namespace :admin do
  root to: 'dashboard#index'  # Example admin dashboard
  resources :posts # Example for moderating posts
  resources :users
  resources :photos
  resources :events # Example for moderating posts
  # ... other admin resources ...
  end

  resources :users, only: [:show, :edit, :update, :destroy]
  resources :events do
    resources :event_participations, only: [:create, :destroy]
    resources :photos, only: [:new, :create, :show, :destroy]
    member do
      post 'join'
      delete 'leave'
    end
  end

  get '/forum', to: 'forum#index'
  namespace :forum do
    get 'new_category', to: 'post_categories#new'
    resources :post_categories do
      resources :posts do
        resources :replies, only: [:new, :create, :show]
      end
    end
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'  
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  # Defines the root path route ("/")
   root "home#index"
end
