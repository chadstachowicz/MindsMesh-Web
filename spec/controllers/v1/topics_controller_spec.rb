require 'spec_helper'

describe V1::TopicsController do

  before do
    @topic_user = Fabricate(:topic_user)
    @topic = @topic_user.topic
    @valid_params = {id: @topic.to_param, access_token: @topic_user.user.access_token}
  end
  describe "show" do

    it "with valid params" do
      V1::TopicPresenter.should_receive(:new).with(@topic)
      get :show, @valid_params
      response.status.should == 200
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
      post = Fabricate(:post, topic: @topic)
      get :posts_with_parents, @valid_params
      response.status.should == 200
      response.body.should include post.user.name
      response.body.should include @topic_user.topic.name
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
      topic = Fabricate(:topic)
      V1::TopicPresenter.should_receive(:array).with([topic])
      get :batch, {topic_ids: [topic.id].join('_')}
      response.status.should == 200
    end

  end
=end

end
