Mindsmesh::Application.routes.draw do
  
  namespace 'api' do

    api_version(:module => "V1", :path=>"v1") do
      resources :posts, only: [:show, :create] do
        member do
          get 'with_children'
          get 'likes'
          get 'likes/with_parents', action: 'likes_with_parents'
          post 'like'
          post 'unlike'
          post 'replies', action: 'create_reply'
        end
      end
      resources :replies, only: [:show] do
        member do
          get 'likes'
          get 'likes/with_parents', action: 'likes_with_parents'
          post 'like'
          post 'unlike'
        end
      end
      resources :topics, only: [:show] do
        member do
          get 'posts'
          get 'posts/with_parents', action: 'posts_with_parents'
          post 'join'
          post 'leave'
        end
        #collection do
        #  get :batch
        #end
      end
      resources :users, only: [:show] do
        member do
          get 'with_children'
          get 'posts'
          get 'posts/with_parents', action: 'posts_with_parents'
        end
        #collection do
        #  get :batch
        #end
      end
      post '/session/login'
      get '/session/me'
      get '/home/posts'
      get '/home/posts/with_parents' => 'home#posts_with_parents'
      get '/home/entities'
      get '/home/entities/with_children' => 'home#entities_with_children'
      get '/home/topics'
      post '/home/search_topics'
      match '*path' => 'base#render_404'

    end
    
  end

  resources :notifies, only: [:index, :destroy]

  match "/delayed_job" => DelayedJobWeb, :anchor => false
  
  get "/privacy" => "pages#privacy"
  get "/terms"   => "pages#privacy"
  get "/support" => "pages#privacy"
  get "/faq"     => "pages#privacy"
  get "/about"   => "pages#privacy"

  resources :notifications, only: [:show]

  #general resources, most of these have permissions
  resources :questionnaires, only: [:index, :show, :destroy]
  resources :entities
  
  resources :topic_users
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get :more_posts
    end
  end
  resources :topics do
    member do
      put :join
      put :leave
      get :more_posts
    end
  end
  resources :posts, except: [:new, :create, :edit] do
    member do
      post 'replies', action: 'create_reply'
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
  put "session/switch"
  match "/auth/:provider/callback" => "session#create"

  #relating to an entity
  get "home/user"
  post "home/user_create_eur"
  get "home/user_entity/:confirmation_token" => "home#user_entity", as: 'home_user_entity'

  #client, a user associated to entity
  match "fb_canvas" => 'home#fb_canvas'
  get '/' => 'home#client', as: 'home_client'
  get "home/more_posts"
  post "home/create_post"
  post "home/change_access_token"
  
  #questionnaire
  post "home/feedback"


  #other roles
  #get "home/moderator"
  #get "home/manager"
  #get "home/admin"
  #get "home/master"

  root to: "home#client"
  get "home/denied", as: 'denied'
end