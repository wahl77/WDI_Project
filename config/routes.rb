RailsProject::Application.routes.draw do

  get "/admin" => 'static_pages#admin'
  get "/about" => 'static_pages#about', as: :about

  get "/logout" => 'sessions#destroy', as: :logout
  get "/signup" => 'users#new', as: :signup
  root :to => 'static_pages#index'

  get "/around_me" => 'items#around_me', as: :around_me
  get "/update_location" => 'locations#new_geotag', as: :geotag

  post "/search" => 'items#search', as: :search

  
  resources :sessions
  resources :users
  resources :items
  resources :addresses
end
