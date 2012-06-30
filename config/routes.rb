Lyrne::Application.routes.draw do

  #general resources, most of these have permissions
  resources :questionnaires, only: [:index, :show, :destroy]
  resources :topic_users
  resources :entities
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :topics do
    member do
      put :join
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
  
  #creating an account
  get "home/guest"
  get "session/logout"
  get "/auth/:provider/callback" => "session#create"

  #relating to an entity
  get "home/user"
  post "home/user_create_eur"
  get "home/user_entity/:confirmation_token" => "home#user_entity", as: 'home_user_entity'

  #client, a user associated to entity
  get '/' => 'home#client', as: 'home_client'
  get "home/more_posts"
  post "home/create_post"
  
  #questionnaire
  post "home/feedback"


  #other roles
  get "home/moderator"
  get "home/manager"
  get "home/admin"
  get "home/master"

  root to: "home#client"
  get "home/denied", as: 'denied'
end