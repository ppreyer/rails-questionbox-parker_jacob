Rails.application.routes.draw do
  resources :questions do
    member do 
      resources :answers
    end
  end
  resources :users
  resources :sessions
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  root 'questions#index'


  namespace :api do
    namespace :v1 do
      resources :questions do
        member do 
          resources :answers
        end
      end
      resources :users
      resources :sessions 
      get 'logout', to: 'sessions#destroy', as: 'logout'
    end
  end
end