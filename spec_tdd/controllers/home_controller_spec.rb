
# MindsMesh (c) 2013

require 'spec_helper'

describe HomeController do

  describe "POST 'create_entity_request'" do
    it "should create an EUR" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      Fabricate(:entity, slug: 'uncc')

      expect {
        get 'create_entity_request', {email: "#{Faker::Internet.user_name}@uncc.edu"}
      }.to change(current_user.entity_user_requests, :count).by(1)
    end
    it "denies access not in role" do
      get 'create_entity_request'
      response.should redirect_to(denied_path)
    end
  end

  describe "GET 'confirm_entity_request'" do
    it "creates a new entity_user" do
      entity_user_request = Fabricate(:entity_user_request)
      expect {
        get "confirm_entity_request", {confirmation_token: entity_user_request.confirmation_token}
      }.to change(entity_user_request.entity.entity_users, :count).by(1)
    end
    it "redirects_to home_index_path" do
      entity_user_request = Fabricate(:entity_user_request)
      get "confirm_entity_request", {confirmation_token: entity_user_request.confirmation_token}
      response.should redirect_to(home_index_path)
    end
    it "logs in the user" do
      entity_user_request = Fabricate(:entity_user_request)
      session[:user_id].should be_nil
      get "confirm_entity_request", {confirmation_token: entity_user_request.confirmation_token}
      session[:user_id].should ==entity_user_request.user_id
    end
    it "shows 404 message for invalid links" do
      get "confirm_entity_request", {confirmation_token: 'aaa'}
      response.should render_template("errors/404")
    end
  end

    describe "POST create_post" do
      describe "with invalid params" do
        it "doesn't create a post" do
          t = Fabricate(:topic, entity_user: current_user_master.entity_users.first)
          tu = Fabricate(:topic_user, topic: t)
          -> {
            get :create_post, {post: {topic_user_id: tu.to_param}}, valid_session
          }.should raise_error(ActiveRecord::RecordInvalid)
        end
      end
      describe "with valid params" do
        it "creates a post" do
          t = Fabricate(:topic, entity_user: current_user_master.entity_users.first)
          tu = Fabricate(:topic_user, topic: t)
          -> {
            get :create_post, {post: {topic_user_id: tu.to_param, text: Faker::Lorem.sentence}}, valid_session
          }.should change(Post, :count).by(1)
          response.should render_template("posts/_post")
        end
      end
    end

    describe "GET more_posts" do
      describe "empty set" do
        it "renders template" do
          get :more_posts, {}, valid_session
          response.should render_template("posts/more_posts")
          response.should_not render_template("layouts/application")
        end
      end
      describe "with posts" do
        it "with some posts" do
          t = Fabricate(:topic, entity_user: current_user_master.entity_users.first)
          tu = Fabricate(:topic_user, topic: t)
          pst = Fabricate(:post, topic_user: tu)
          get :more_posts, {}, valid_session
          assigns(:posts).should == [pst]
      end
    end
    
  end

  describe "change_access_token" do
    it "delegates the method to the user" do
      controller.stub(:current_user).and_return(current_user_master)
      current_user_master.stub(:change_access_token)
      current_user_master.should_receive(:change_access_token).once
      post :change_access_token, {}, valid_session
      response.body.should be_blank
    end
  end

end
