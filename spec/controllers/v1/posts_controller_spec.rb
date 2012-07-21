require 'spec_helper'

describe V1::PostsController do

  describe "show" do

    it "with valid params" do
      post = Fabricate(:post)
      V1::PostPresenter.should_receive(:new).with(post)
      get :show, {id: post.to_param}
      response.status.should == 200
    end
    
  end

  describe "with_children" do

    it "with valid params" do
      reply = Fabricate(:reply)
      post = reply.post
      get :with_children, {id: post.to_param}
      response.status.should == 200
      response.body.should include 'replies'
      response.body.should include reply.text
    end
    
  end

end
