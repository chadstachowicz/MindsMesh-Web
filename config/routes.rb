Mindsmesh::Application.routes.draw do

  resources :notification_settings


  resources :notification_settings_times


  resources :background_jobs

  resources :email_campaigns

  resources :post_hashtags

  resources :hashtags
  resources :feedback_bugs

  resources :entity_user_lms

  resources :entity_lms

  resources :lms_providers

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks"}

  #rails generate versionist:new_controller notifications api/V1
  #then adapt the generated files
    
    
  namespace 'api' do

    api_version(:module => "V1", :path=> {:value => "v1"}) do
      resources :posts, only: [:index, :show, :create] do
        member do
          get 'with_children'
          get 'with_family'
          get 'likes'
          get 'likes/with_parents', action: 'likes_with_parents'
          post 'like'
          post 'unlike'
          post 'replies', action: 'create_reply'
        end
        collection do
          get 'with_family', action: 'posts_with_family'
        end
      end
      resources :notifications, only: [:show] do
            collection do
                get 'grouped/with_parents', action: 'grouped_with_parents'
            end
            member do
                post 'mark_as_read'
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
      resources :topics, only: [:show, :create] do
        member do
          get 'posts'
          get 'posts/with_family', action: 'posts_with_family'
          post 'join'
          post 'leave'
        end
      end
      resources :groups, only: [:show, :create] do
        member do
            get 'posts'
            get 'posts/with_family', action: 'posts_with_family'
            post 'join'
            post 'leave'
        end
      end
      resources :users, only: [:show] do
        member do
          get 'with_children'
          post 'create'
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
      post '/posts/encode_video' => 'posts#encode_video'
      post '/home/register_device'
      post "/home/entities" => "home#create_entity_request"
      match '*path' => 'base#render_404'

    end
    
  end

  resources :notifies, only: [:index, :destroy]


  #for now, we're sending IRs to login, but we plan on making a custom login page showing invitor, entity and topic
  resources :invite_requests, only: [:create] #, :show
  #get "invited/:id" => "invite_requests#show", as: :nice_invite_request
  get "invited/:id(/:name)" => "home#denied", as: :nice_invite_request

  mount MailsViewer::Engine => '/delivered_mails'
  
  get "/privacy" => "pages#privacy"
  get "/product_tour" => "pages#product_tour"
  get "/terms"   => "pages#terms"
  get "/support" => "pages#privacy"
  get "/faq"     => "pages#privacy"
  get "/saml"     => "home#saml"
  get "/about"   => "pages#privacy"

  resources :notifications, only: [:show]
    resources :entity_advanced_settings
          resources :hashtags
  #general resources, most of these have permissions
  resources :questionnaires, only: [:index, :show, :destroy]
  resources :entities do
      get :settings
      get :lti
      post :lti
    collection do
      get 'select2_filter', format: 'js'
      get 'datatable_filter', format: 'json'
    end
  end
  
  resources :entity_users
  resources :group_users
  resources :topic_users
    resources :messages
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do
        get :more_posts
        put :follow
        put :unfollow
      end
      collection do
          get :filter
          get 'datatable_filter', format: 'json'
          post :import
      end
    end
  resources :topics do
    member do
      put :join
      put :leave
      get :more_posts
    end
    collection do
      get :filter
      get 'datatable_filter', format: 'json'
      post :import
    end
  end
    
    resources :rosters do
        member do
        end
        collection do
            get :filter
            get 'datatable_filter', format: 'json'
            post :import
        end
    end

    
  resources :groups do
    member do
        put :join
        put :leave
        get :more_posts
    end
  end
  resources :settings do
      collection do
      get :notifications
      end
  end
  resources :posts, except: [:new, :create, :edit] do
    member do
      post 'replies', action: 'create_reply'
      post 'like'
      post 'unlike'
    end
  end
  resources :post_attachments, only: [:destroy]
  resources :replies, only: [:update, :destroy] do
    member do
      put 'like'
    end
  end
  
  #creating an account
  get "home/login" => "home#ucmesh_login", :constraints => { :domain => "ucmesh.com" }
  get "home/login" => "home#edumesh_login", :constraints => { :domain => "edumesh.com" }
  get "home/login"
  get "session/logout"
  put "session/switch"
  match "/auth/:provider/callback" => "session#create"
  match "/auth/failure" => "home#denied"
    
  match "/auth/failure" => "home#denied"
  #relating to an entity
  get "home/entities"
  post "home/entities" => "home#create_entity_request", as: 'home_create_entity_request'
  get "home/confirm/:confirmation_token" => "home#confirm_entity_request", as: 'home_confirm_entity_request'
    
    post "home/signup" => "home#create_signup_request", as: 'home_create_signup_request'
    get "home/confirm_signup/:confirmation_token" => "home#confirm_signup_request", as: 'home_confirm_signup_request'

   get "join/:token" => "home#join_entity"

  #client, a user associated to entity
  match "fb_canvas" => 'home#fb_canvas'
  match "home/search" => 'home#search_users'
  match 'switch_user' => 'switch_user#set_current_user'
  get '/' => 'home#index', as: 'home_index'
  get '/admin' => 'admin#index', as: 'admin_index'
  get "home/more_posts"
  get "hashtags/more_posts"
  get "hash/:tag" => "hashtags#show"
  post "home/create_post"
  post "home/create_message"
  post "home/change_access_token"
  get '/home/topics'
  post 'home/fb_requests_sent'
    get "home/demoforik12"
  
  #ajax
  get "home/ajax_application", format: 'js'

  #questionnaire
  post "home/feedback"


  #other roles
  #get "home/moderator"
  #get "home/manager"
  #get "home/admin"
  #get "home/master"

  root to: "home#index"
  get "home/denied", as: 'denied'


  # Admin email manager  3-XII-13
  namespace :admin do

    #get  "select"    => "panels#index",   :as => 'panela_index'
    resources :panels do
      collection do
          get  "index"    => "panels#index",   :as => 'pindex'
          get  "statics"  => "panels#statics", :as => 'statics'
          get  "recent"   => "panels#recent",  :as => 'recent'
          get  "posts"    => "panels#posts",   :as => 'posts'
      end
    end

    resources :campaigns do
      collection do
          post  "groups/"      => "campaigns#groups",   :as => 'groups'
          get   "sendcamp/:id" => "campaigns#sendcamp", :as => 'sendcamp'
      end
    end

    resources :newsletters do
      collection do
          get   "select/:id"           => "newsletters#select",       :as => 'ns_select'
          get   "test/:id"             => "newsletters#test",         :as => 'test'
          get   "send/"                => "newsletters#send",         :as => 'send'
          post  "generalstats/"        => "newsletters#generalstats", :as => 'generalstats'
          get   "settings/"            => "newsletters#settings",     :as => 'settings'
          get   "statics/:id"          => "newsletters#statics",      :as => 'statics'
          get   "categories"           => "newsletters#categories",   :as => 'categories'
          post  "groups/"              => "newsletters#groups",       :as => 'groups'
      end
    end
  end
  
end
