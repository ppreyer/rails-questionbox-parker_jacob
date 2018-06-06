Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root 'questions#index'
      resources :questions do
        member do
          resources :answers
        end
      end
      resources :users
      resources :sessions 
    end
  end
end