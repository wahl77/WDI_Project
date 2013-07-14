RailsProject::Application.routes.draw do
  root :to => 'static_pages#index'

  get "/login" => 'bal#bla', as: :login
end
