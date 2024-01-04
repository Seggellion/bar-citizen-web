Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  # Define a route for standard pages
  get 'pages/:title', to: 'pages#show', as: :page

  # Define a route for nested pages
  get 'pages/:category/:title', to: 'pages#show_nested', as: :nested_page


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/api/exchange_token', to: 'authentication#exchange_token'

  get '/api/redirect_to_discord', to: 'authentication#redirect_to_discord'
  get '/api/discord/callback', to: 'authentication#discord_callback'
  get '/api/discord/start_auth', to: 'authentication#start_auth'

  get '/map', to: 'maps#index'

  resources :regions

  resources :discords
  resources :photos do
    resources :photo_comments do 
      post 'upvote'
      post 'downvote'
    end
    member do
      post 'view'
      post 'upvote'
      post 'downvote'
    end
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  resources :votes, only: [:create]
  get '/dashboard', to: 'home#dashboard'
  get '/gallery', to: 'home#gallery'
  resources :messages
  # Events
 # get '/events/new', to: 'events#new', as: 'new_event'
 # get '/events', to: 'events#index', as: 'find_event'
 # post '/events', to: 'events#create'

 #post '/admin/events/:id/publish', to: 'admin#publish_event', as: 'publish_event'
 #post '/admin/events/:id/trash', to: 'admin#trash_event', as: 'trash_event'

 namespace :api do
  resources :regions, only: [:index], defaults: { format: :json }
  resources :events, only: [:index], defaults: { format: :json }
  # other API routes...
end

  namespace :admin do
    root to: 'dashboard#index'  # Example admin dashboard
    get '/calendar', to: 'calendar#index'

    resources :events do
      collection do
        get 'all', to: 'events#all'  # Adding this line
      end
      member do
        post 'publish'
        post 'trash'
      end
    end

    resources :regions do
      member do
        post 'publish'
        post 'trash'
      end
    end
    resources :sections, only: [:create, :destroy, :update]
    resources :blocks, only: [:create, :destroy, :update]
    resources :settings 
    resources :pages
    resources :posts do
      member do
        post 'trash'
      end
    end

    resources :replies do
      member do
        post 'trash'
      end
    end

    resources :messages do
      member do
        post 'trash'
      end
    end

    resources :badges do
      member do
        post 'trash'
      end
    end

    resources :user_badges do
      member do
        post 'trash'
      end
    end
    
    resources :discords do
      member do
        post 'publish'
        post 'unpublish'
        post 'trash'
      end
    end

    resources :users do
      member do
        post 'publish'
        post 'unpublish'
        post 'trash'
        patch :update_user_level, to: 'users#update_user_level'
      end
    end

    resources :photos do
      member do
        post 'publish'
        post 'unpublish'
        post 'trash'
      end
    end
  # ... other admin resources ...
  end

  resources :users, only: [:show, :edit, :update, :destroy]
  get 'new_category', to: 'post_categories#new'
  get 'virtual-events', to: 'events#virtual'
  get 'virtual-events/:slug', to: 'events#show_virtual', as: 'virtual_event'

  resources :events do
    resources :event_participations, only: [:create, :destroy]
    resources :photos, only: [:new, :create, :show, :destroy]
    resources :event_managers
    resources :giveaways do
      member do
        post 'draw_winner'
      end
    end
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
  get '/invite', to: 'events#invite', as: 'invite'


  # Defines the root path route ("/")
   root "home#index"
   get '/:id', to: 'regions#show', as: :region_shortcut
end
