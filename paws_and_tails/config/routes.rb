Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  post '/login/create', to: 'sessions#create'

  resources :users
  resources :sessions

  get '/breeders/redesigned_destroy/:id', to: "breeders#redesigned_destroy"
  get '/animals/redesigned_destroy/:id', to: "animals#redesigned_destroy"

  get '/messages/:to_user_id', to: "messages#show"
  post '/messages/api/new', to: "messages#create"
  get '/messages/inbox/show', to: "messages#inbox"

  post '/waitlists/join', to: "waitlists#join"
  post '/waitlists/leave', to: "waitlists#leave"
  get '/waitlists/manage/remove/:user_id/:animal_id', to: "waitlists#manage_remove"

  # get "/link", to: "users#link_user_with_breeder"

  # get 'animal/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "animals#index"
  resources :animals
  resources :breeders

  post "/animals/api/sort_location", to: "animals#sort_location"

  match '*unmatched', to: 'application#not_found_method', via: :all

  # get "/animals", to: "animals#index"
  # get "/animals/:id", to: "animals#show"
end
