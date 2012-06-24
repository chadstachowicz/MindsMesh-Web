require 'spec_helper'

describe RepliesController do

  before(:each) do
    @reply = Fabricate(:reply)
    stub!(:current_user).and_return(current_user_master)
  end

  describe "PUT like" do

    it "creates like" do
      -> {
        put :like, {:id => @reply.to_param}, valid_session
      }.should change(Like, :count).by(1)
    end

    it "creates like assiciated with @reply" do
      -> {
        put :like, {:id => @reply.to_param}, valid_session
      }.should change(@reply.likes, :count).by(1)
    end

    it "creates like assiciated with current_user" do
      -> {
        put :like, {:id => @reply.to_param}, valid_session
      }.should change(current_user.likes, :count).by(1)
    end

    it "can't like @reply twice" do
      -> {
        put :like, {:id => @reply.to_param}, valid_session
        put :like, {:id => @reply.to_param}, valid_session
      }.should change(current_user.likes, :count).by(1)
    end

    it "renders nothing" do
      put :like, {:id => @reply.to_param}, valid_session
      response.body.should == @reply.likes.size.to_s
    end

  end

end