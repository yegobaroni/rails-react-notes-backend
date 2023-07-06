Rails.application.routes.draw do
  resources :notes
  resources :users, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  get "/users", to: "users#index"
end
