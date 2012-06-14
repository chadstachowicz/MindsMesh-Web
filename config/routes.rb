Lyrne::Application.routes.draw do
  get "home/index"

  get "home/guest"

  get "home/user"

  get "home/student"

  get "home/moderator"

  get "home/teacher"

  get "home/admin"

  get "home/master"

  resources :schools

  get "session/login"
  get "session/logout"
  get "/auth/:provider/callback" => "session#create"

  resources :users, only: [:index, :show, :edit, :update, :destroy]
  root to: "users#index"
  get "home/index", as: 'denied'
end