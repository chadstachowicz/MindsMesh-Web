require 'spec_helper'

describe V1::UsersController do

  before do
    @me = Fabricate(:user)
    @user = Fabricate(:user)
    @valid_params = {access_token: @me.access_token, id: @user.to_param}
  end

  describe "show" do

    it "with valid params" do
      V1::UserPresenter.should_receive(:new).with(@user)
      get :show, @valid_params
      response.status.should == 200
    end
    
  end

  describe "with_children" do

    it "with valid params" do
      topic_user = Fabricate(:topic_user, user: @user)
      topic = topic_user.topic
      entity = topic.entity
      Fabricate(:entity_user, entity: entity, user: @user)

      get :with_children, @valid_params
      response.status.should == 200
      response.body.should include 'topic_users'
      response.body.should include topic.name
      response.body.should include 'entity_users'
      response.body.should include entity.name
    end
    
  end

  describe "posts" do

    it "with valid params" do
      V1::PostPresenter.should_receive(:array).with([])
      get :posts, @valid_params
      response.status.should == 200
    end
    
  end

  describe "posts_with_parents" do

    it "with one post" do
      post = Fabricate(:post, user: @user)
      get :posts_with_parents, @valid_params
      response.status.should == 200
      response.body.should include post.user.name
      response.body.should include post.topic.name
      #assigns(:posts).should == [V1::PostPresenter.new(post)]
      #I don't think it's necessary to validate the json rendering
    end
    
  end
  
=begin
  describe "batch" do
    
    it "with invalid params" do
      get :batch, {}
      response.status.should == 406
    end
    
    it "with valid params" do
      user = Fabricate(:user)
      V1::UserPresenter.should_receive(:array).with([user])
      get :batch, {user_ids: [user.id].join('_')}
      response.status.should == 200
    end

  end
=end

end
