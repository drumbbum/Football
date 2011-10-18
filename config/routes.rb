Football::Application.routes.draw do
  resources :leagues
  resources :profiles
  devise_for :users
  root :to => "profiles#show"
end
