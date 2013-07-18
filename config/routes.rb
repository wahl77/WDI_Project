RailsProject::Application.routes.draw do

  get "/logout" => 'sessions#destroy', as: :logout
  get "/signup" => 'users#new', as: :signup
  root :to => 'static_pages#index'

  get "/around_me" => 'items#around_me', as: :around_me
  get "/update_location" => 'locations#new_geotag', as: :geotag

  
  resources :sessions
  resources :users
  resources :items
  resources :addresses
end
