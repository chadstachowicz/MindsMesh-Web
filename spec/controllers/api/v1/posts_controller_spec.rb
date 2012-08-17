require 'spec_helper'

describe Api::V1::PostsController do

  before do
    @topic_user = Fabricate(:topic_user)
    @post = Fabricate(:post, topic: @topic_user.topic)
    @me = @topic_user.user
    @valid_params = {access_token: @me.access_token}
  end

  describe "show" do

    it "with valid params" do
      Api::V1::PostPresenter.should_receive(:new).with(@post)
      get :show, @valid_params.merge({id: @post.to_param})
      response.status.should == 200
    end
    
  end

  describe "with_children" do

    it "with valid params" do
      reply = Fabricate(:reply, post: @post)
      get :with_children, @valid_params.merge({id: @post.to_param})
      response.status.should == 200
      response.body.should include 'replies'
      response.body.should include reply.text
    end
    
  end

  describe "likes" do

    it "with valid params" do
      like = Fabricate(:like, likable: @post)
      get :likes, @valid_params.merge({id: @post.to_param})
      response.status.should == 200
    end
    
  end

  describe "likes_with_parents" do

    it "with valid params" do
      like = Fabricate(:like, likable: @post)
      get :likes_with_parents, @valid_params.merge({id: @post.to_param})
      response.status.should == 200
      response.body.should include like.user.name
    end
    
  end

  describe "like" do

    it "with valid params" do
      Like.stub(:create)
      Like.should_receive(:create)
      get :like, @valid_params.merge({id: @post.to_param})
      response.status.should == 200
    end

    it "with invalid params" do
      Fabricate(:like, likable: @post, user: @me)
      ->{
      get :like, @valid_params.merge({id: @post.to_param})
      }.should_not change(Like, :count)
      response.status.should == 200
    end
    
  end

  describe "unlike" do

    it "with invalid params" do
      Like.any_instance.should_not_receive(:destroy)
      get :unlike, @valid_params.merge({id: @post.to_param})
      response.status.should == 200
    end

    it "with valid params" do
      Fabricate(:like, likable: @post, user: @me)
      Like.any_instance.should_receive(:destroy)
      get :unlike, @valid_params.merge({id: @post.to_param})
      response.status.should == 200
    end
    
  end

  describe "create" do

    it "with valid params" do
      Api::V1::PostPresenter.any_instance.should_receive(:as_json)
      prms = {post: {topic_user_id: @topic_user.id, text: Faker::Lorem.sentence}}

      get :create, @valid_params.merge(prms)
      response.status.should == 200
    end
    
  end

  describe "create_reply" do

    it "with invalid params" do
      get :create_reply, @valid_params.merge({id: @post.to_param})
      response.status.should == 406
    end

    it "with valid params" do
      get :create_reply, @valid_params.merge({id: @post.to_param, reply: {text: 'a'}})
      response.status.should == 200
    end
    
  end

end
