require 'spec_helper'

describe HomeController do

  describe "authorization" do

    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        response.should be_redirect
        #pending "this is an action for logical decisions"
      end
    end

    describe "GET 'basic'" do
      it "returns http success if not logged in" do
        get 'basic'
        response.should be_success
      end
      it "denies access if logged in" do
        session[:user_id] = Fabricate(:user).id
        get 'basic'
        response.should redirect_to(denied_path)
      end
    end

    describe "GET 'guest'" do
      it "returns http success if in role" do
        session[:user_id] = Fabricate(:user).id
        Fabricate(:entity)
        get 'guest'
        response.should be_success
      end
      it "denies access not in role" do
        session[:user_id] = Fabricate(:user, roles_s: 'user').id
        get 'guest'
        response.should redirect_to(denied_path)
      end
    end

    describe "POST 'guest_create_eur'" do
      it "should create a request" do
        current_user = Fabricate(:user)

        session[:user_id] = current_user.id

        expect {
          post 'guest_create_eur', {
            format: 'js',
            entity_user_request: {
              entity_id: Fabricate(:entity).id,
              email: "#{Faker::Internet.user_name}@uncc.edu"
            }
          }
        }.to change(current_user.entity_user_requests, :count).by(1)
      end
      it "denies access not in role" do
        session[:user_id] = Fabricate(:user, roles_s: 'user').id
        post 'guest_create_eur'
        response.should redirect_to(denied_path)
      end
    end

    describe "GET 'user_entity'" do
      it "creates a new entity_user" do
        entity_user_request = Fabricate(:entity_user_request)
        expect {
          get "user_entity", {confirmation_token: entity_user_request.confirmation_token}
        }.to change(entity_user_request.entity.entity_users, :count).by(1)
      end
      it "destroys that confirmation_token" do
        entity_user_request = Fabricate(:entity_user_request)
        expect {
          get "user_entity", {confirmation_token: entity_user_request.confirmation_token}
        }.to change(EntityUserRequest, :count).by(-1)
      end
      it "redirects_to home_user_path" do
        entity_user_request = Fabricate(:entity_user_request)
        get "user_entity", {confirmation_token: entity_user_request.confirmation_token}
        response.should redirect_to(home_user_path)
      end
      it "logs in the user" do
        entity_user_request = Fabricate(:entity_user_request)
        session[:user_id].should be_nil
        get "user_entity", {confirmation_token: entity_user_request.confirmation_token}
        session[:user_id].should ==entity_user_request.user_id
      end
      it "shows 404 message for invalid links" do
        get "user_entity", {confirmation_token: 'aaa'}
        response.should render_template("errors/404")
      end
    end

    describe "GET 'user'" do
      it "returns http success if in role" do
        session[:user_id] = Fabricate(:user, roles_s: 'user').id
        get 'user'
        response.should be_success
      end
      it "denies access not in role" do
        session[:user_id] = Fabricate(:user).id
        get 'user'
        response.should redirect_to(denied_path)
      end
    end

    describe "GET 'moderator'" do
      it "returns http success if in role" do
        session[:user_id] = Fabricate(:user, roles_s: 'moderator').id
        get 'moderator'
        response.should be_success
      end
      it "denies access not in role" do
        session[:user_id] = Fabricate(:user).id
        get 'moderator'
        response.should redirect_to(denied_path)
      end
    end

    describe "GET 'manager'" do
      it "returns http success if in role" do
        session[:user_id] = Fabricate(:user, roles_s: 'manager').id
        get 'manager'
        response.should be_success
      end
      it "denies access not in role" do
        session[:user_id] = Fabricate(:user).id
        get 'manager'
        response.should redirect_to(denied_path)
      end
    end

    describe "GET 'admin'" do
      it "returns http success if in role" do
        session[:user_id] = Fabricate(:user, roles_s: 'admin').id
        get 'admin'
        response.should be_success
      end
      it "denies access not in role" do
        session[:user_id] = Fabricate(:user).id
        get 'admin'
        response.should redirect_to(denied_path)
      end
    end

    describe "GET 'master'" do
      it "returns http success if in role" do
        session[:user_id] = Fabricate(:user, roles_s: 'master').id
        get 'master'
        response.should be_success
      end
      it "denies access not in role" do
        session[:user_id] = Fabricate(:user).id
        get 'master'
        response.should redirect_to(denied_path)
      end
    end
    
  end

  describe "rendering" do

    describe "GET 'user'" do
      before(:each) do
        @topic_user = Fabricate(:topic_user, user: current_user_master)
        3.times do
          Fabricate(:post, topic_user: @topic_user, text: Faker::Lorem.sentence)
        end
      end
      it "renders posts" do
        get 'user', {}, valid_session
        assigns(:posts).size.should == 3
      end
    end

    describe "POST create_post" do
      before(:each) do
        @topic_user = Fabricate(:topic_user, user: current_user_master)
      end
      describe "with invalid params" do
        it "doesn't create a post" do
          -> do
            post :create_post, {topic_user_id: @topic_user.to_param, post: {}}, valid_session
          end.should change { @topic_user.posts.count }.by(0)
        end
        it "renders show template" do
          post :create_post, {topic_user_id: @topic_user.to_param, post: {}}, valid_session
          assigns(:post).should be_a(Post)
          assigns(:post).errors.should_not be_empty
        end
      end
      describe "with valid params" do
        it "creates a post" do
          -> do
            post :create_post, {topic_user_id: @topic_user.to_param, post: {text: Faker::Lorem.sentence}}, valid_session
          end.should change { Post.count }.by(1)
        end
        it "creates a post associated with current_user" do
          -> do
            post :create_post, {topic_user_id: @topic_user.to_param, post: {text: Faker::Lorem.sentence}}, valid_session
          end.should change { current_user_master.posts.count }.by(1)
        end
        it "creates a post associated with @topic_user" do
          -> do
            post :create_post, {topic_user_id: @topic_user.to_param, post: {text: Faker::Lorem.sentence}}, valid_session
          end.should change { @topic_user.posts.count }.by(1)
        end
        it "creates a post associated with @topic_user.topic" do
          -> do
            post :create_post, {topic_user_id: @topic_user.to_param, post: {text: Faker::Lorem.sentence}}, valid_session
          end.should change { @topic_user.topic.posts.count }.by(1)
        end
        it "creates a post associated with @topic_user" do
          post :create_post, {topic_user_id: @topic_user.to_param, post: {text: Faker::Lorem.sentence}}, valid_session
          assigns(:post).should be_a(Post)
        end
      end
    end

    describe "GET more_posts" do
      before(:each) do
        @topic_user = Fabricate(:topic_user, user: current_user_master)
      end
      describe "empty set" do
        it "renders template" do
          get :more_posts, {format: 'js'}, valid_session
          response.should render_template("posts/more_posts")
        end
      end
      describe "with posts" do
        before(:each) do
          3.times do
            Fabricate(:post, topic_user: @topic_user, text: Faker::Lorem.sentence)
          end
        end
        it "with some posts" do
          get :more_posts, {}, valid_session
          assigns(:posts).size.should == 3
        end
        it "applying before" do
          get :more_posts, {before: Post.last.id}, valid_session
          assigns(:posts).size.should == 2
        end
        it "applying limit" do
          get :more_posts, {limit: 1}, valid_session
          assigns(:posts).size.should == 1
        end
        #it "applying after"
      end
    end
    
  end

end