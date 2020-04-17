Rails.application.routes.draw do

  get 'sessions/create'
  get 'users/new'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "tasks#index"
  
  resources :tasks

  resources :users, only: [:new, :create]
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
end
