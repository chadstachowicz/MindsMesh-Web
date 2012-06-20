Lyrne::Application.routes.draw do

  resources :section_users

  resources :sections do
    member do
      put :join
      #get :posts, format: 'js'
      get :more_posts, format: 'js'
    end
  end
  resources :posts, except: [:new, :create] do
    member do
    end
  end
  resources :courses
  resources :schools
  
  get "home/index"
  post "home/index" => "home#create_post"
  
  get "home/guest"
  get "session/logout"
  get "/auth/:provider/callback" => "session#create"

  get "home/user"
  post "home/user" => "home#user_create_school_request", format: 'js'
  get "home/user_school/:confirmation_token" => "home#user_school", as: 'home_user_school'



  get "home/student"
  get "home/moderator"
  get "home/teacher"
  get "home/admin"
  get "home/master"
  get "home/more_posts", format: 'js'
  post "home/create_post", format: 'js'


  resources :users, only: [:index, :show, :edit, :update, :destroy]
  root to: "home#index"
  get "home/index", as: 'denied'
end