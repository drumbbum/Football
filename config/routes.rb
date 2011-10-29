Football::Application.routes.draw do
  resources :picks
  resources :matchups
  resources :leagues
  resources :profiles
  devise_for :users
  
  get "tools" => "admin#tools", :as => "admin_tools"
  
  root :to => "profiles#show"
end
