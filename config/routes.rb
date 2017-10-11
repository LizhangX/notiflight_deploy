Rails.application.routes.draw do
  get 'auth/:provider/callback' => 'sessions#create'
  post 'login' => 'sessions#login'
  post 'register' => 'users#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]
  resources :users, only: [:create, :show]
  resources :flights, only: [:create, :destroy]

  post 'flights/track' => 'flights#track'
  get 'search' => 'users#search'
  root to: "home#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
