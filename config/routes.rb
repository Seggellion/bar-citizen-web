Rails.application.routes.draw do
  resources :photos
  resources :event_participations
  resources :events
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
 


  Rails.application.routes.draw do
    resources :users, only: [:show, :edit, :update, :destroy]
    resources :events do
      resources :photos, only: [:new, :create, :show, :destroy]
      member do
        post 'join'
        delete 'leave'
      end
    end
  end
  

  # Defines the root path route ("/")
   root "home#index"
end
