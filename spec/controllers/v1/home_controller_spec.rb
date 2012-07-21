require 'spec_helper'

describe V1::HomeController do

  before do
    @topic_user = Fabricate(:topic_user)
    @current_user = @topic_user.user
    @valid_params = {access_token: @current_user.id}
  end

  describe "posts" do

    it "without posts" do
      V1::PostPresenter.should_receive(:array).with([])
      get :posts, @valid_params
      response.status.should == 200
      #assigns(:posts).should == []
    end

    it "with one post" do
      post = Fabricate(:post, user: @topic_user.user, topic: @topic_user.topic)
      V1::PostPresenter.should_receive(:array).with([post])
      get :posts, @valid_params
      response.status.should == 200
      #assigns(:posts).should == [V1::PostPresenter.new(post)]
      #I don't think it's necessary to validate the json rendering
    end

  end

  describe "posts_with_includes" do

    it "with one post" do
      post = Fabricate(:post, user: @topic_user.user, topic: @topic_user.topic)
      get :posts_with_includes, @valid_params
      response.status.should == 200
      response.body.should include @topic_user.user.name
      response.body.should include @topic_user.topic.name
      #assigns(:posts).should == [V1::PostPresenter.new(post)]
      #I don't think it's necessary to validate the json rendering
    end
    
  end

end
