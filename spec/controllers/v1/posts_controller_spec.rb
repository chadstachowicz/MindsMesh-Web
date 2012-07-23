require 'spec_helper'

describe V1::PostsController do

  before do
    @me = Fabricate(:user)
    @valid_params = {access_token: @me.access_token}
  end

  describe "show" do

    it "with valid params" do
      post = Fabricate(:post)
      V1::PostPresenter.should_receive(:new).with(post)
      get :show, @valid_params.merge({id: post.to_param})
      response.status.should == 200
    end
    
  end

  describe "with_children" do

    it "with valid params" do
      reply = Fabricate(:reply)
      post = reply.post
      get :with_children, @valid_params.merge({id: post.to_param})
      response.status.should == 200
      response.body.should include 'replies'
      response.body.should include reply.text
    end
    
  end

  describe "create" do

    it "with valid params" do
      topic_user = Fabricate(:topic_user, user: @me)
      V1::PostPresenter.any_instance.should_receive(:as_json)
      prms = {topic_user_id: topic_user.id, post: {text: Faker::Name.name}}

      get :create, @valid_params.merge(prms)
      response.status.should == 200
    end
    
  end

end
