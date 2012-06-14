Lyrne::Application.routes.draw do
  get "home/index"
  
  get "home/guest"
  get "session/logout"
  get "/auth/:provider/callback" => "session#create"

  get "home/user"
  post "home/user" => "home#user_create_school_request", format: 'js'


  get "home/student"
  get "home/moderator"
  get "home/teacher"
  get "home/admin"
  get "home/master"

  resources :schools


  resources :users, only: [:index, :show, :edit, :update, :destroy]
  root to: "users#index"
  get "home/index", as: 'denied'
end