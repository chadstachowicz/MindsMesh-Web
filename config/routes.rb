Lyrne::Application.routes.draw do
  get "session/login"
  get "session/logout"
  get "/auth/:provider/callback" => "session#create"

  resources :users, only: [:index, :show, :edit, :update, :destroy]
  root to: "users#index"
end