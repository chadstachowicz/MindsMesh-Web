require 'spec_helper'

describe V1::RepliesController do

  before do
    @me = Fabricate(:user)
    @valid_params = {access_token: @me.access_token}
  end

  describe "show" do

    it "with valid params" do
      reply = Fabricate(:reply)
      V1::ReplyPresenter.should_not_receive(:new).with(reply)
      get :show, @valid_params.merge({id: reply.to_param})
      response.status.should == 200
    end
    
  end

  describe "likes" do

    it "with valid params" do
      like = Fabricate(:like, likable: Fabricate(:reply))
      reply = like.likable
      get :likes, @valid_params.merge({id: reply.to_param})
      response.status.should == 200
    end
    
  end

  describe "likes_with_parents" do

    it "with valid params" do
      like = Fabricate(:like, likable: Fabricate(:reply))
      reply = like.likable
      get :likes_with_parents, @valid_params.merge({id: reply.to_param})
      response.status.should == 200
      response.body.should include like.user.name
    end
    
  end

  describe "like" do

    it "with valid params" do
      reply = Fabricate(:reply)
      Like.stub(:create)
      Like.should_receive(:create)
      get :like, @valid_params.merge({id: reply.to_param})
      response.status.should == 200
    end

    it "with invalid params" do
      reply = Fabricate(:reply)
      Fabricate(:like, likable: reply, user: @me)
      ->{
      get :like, @valid_params.merge({id: reply.to_param})
      }.should_not change(Like, :count)
      response.status.should == 200
    end
    
  end

  describe "unlike" do

    it "with invalid params" do
      reply = Fabricate(:reply)
      Like.any_instance.should_not_receive(:destroy)
      get :unlike, @valid_params.merge({id: reply.to_param})
      response.status.should == 200
    end

    it "with valid params" do
      reply = Fabricate(:reply)
      Fabricate(:like, likable: reply, user: @me)
      Like.any_instance.should_receive(:destroy)
      get :unlike, @valid_params.merge({id: reply.to_param})
      response.status.should == 200
    end
    
  end

end
