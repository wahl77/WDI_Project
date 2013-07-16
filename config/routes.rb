RailsProject::Application.routes.draw do
  get "sessions/new"
  get "/logout" => 'sessions#destroy', as: :logout
  get "/signup" => 'users#new', as: :signup
  root :to => 'static_pages#index'

  
  resources :sessions
  resources :users
  resources :items
end
