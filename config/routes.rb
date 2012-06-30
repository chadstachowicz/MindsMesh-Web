Lyrne::Application.routes.draw do

  resources :questionnaires, only: [:index, :show, :destroy]

  resources :topic_users

  resources :topics do
    member do
      put :join
      #get :posts, format: 'js'
      get :more_posts
    end
  end
  resources :posts, except: [:new, :create, :edit] do
    member do
      post 'replies'
      put 'like'
    end
  end
  resources :replies, only: [:update, :destroy] do
    member do
      put 'like'
    end
  end
  resources :entities
  
  get "home/index"
  post "home/index" => "home#create_post"
  
  get "home/guest"
  get "session/logout"
  get "/auth/:provider/callback" => "session#create"

  get "home/user"
  post "home/user_create_eur"
  get "home/user_entity/:confirmation_token" => "home#user_entity", as: 'home_user_entity'

  
  get "home/client"
  get "home/moderator"
  get "home/manager"
  get "home/admin"
  get "home/master"

  get "home/more_posts", format: 'js'
  post "home/create_post", format: 'js'
  
  post "home/feedback"


  resources :users, only: [:index, :show, :edit, :update, :destroy]
  root to: "home#index"
  get "home/index", as: 'denied'
end