RailsProject::Application.routes.draw do
  get "sessions/new"
  get "/logout" => 'sessions#destroy', as: :logout
  get "/signup" => 'users#new', as: :signup
  root :to => 'static_pages#index'

  get "/login" => 'bal#bla', as: :login
  
  resources :sessions
  resources :users
end
