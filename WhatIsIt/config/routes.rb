Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      root 'questions#index'
      resources :questions do
        member do
          resources :answers
        end
      end 
    end
  end
  
  get 'session', to: 'sessions#new'
  post 'session', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end