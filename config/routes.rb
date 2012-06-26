Lyrne::Application.routes.draw do

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
  
  get "home/basic"
  get "session/logout"
  get "/auth/:provider/callback" => "session#create"

  get "home/guest"
  post "home/guest_create_eur"#, format: 'js'
  get "home/user_entity/:confirmation_token" => "home#user_entity", as: 'home_user_entity'

  
  get "home/user"
  get "home/moderator"
  get "home/manager"
  get "home/admin"
  get "home/master"

  get "home/more_posts", format: 'js'
  post "home/create_post", format: 'js'


  resources :users, only: [:index, :show, :edit, :update, :destroy]
  root to: "home#index"
  get "home/index", as: 'denied'
end