Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :records
      resources :artists
    end
  end
  post "refresh", to: "refresh#create"
  post "signin", to: "signin#create"
  delete "signin", to: "signin#destroy"
  post "signup", to: "signup#create"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
