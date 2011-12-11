Football::Application.routes.draw do
  get "leagues/select" => "leagues#select", :as => "leagues_select"
  put "leagues/pick_league" => "leagues#pick_league", :as => "league_pick_league"
  
  
  resources :comments
  resources :memberships
  resources :picks
  resources :matchups
  resources :leagues
  resources :profiles
  devise_for :users
  
  get "tools" => "admin#tools", :as => "admin_tools"
  root :to => "profiles#show"
end
