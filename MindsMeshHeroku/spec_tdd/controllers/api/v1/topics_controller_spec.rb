require 'spec_helper'

describe Api::V1::TopicsController do

  before do
    entity_user = Fabricate(:entity_user)
    @topic      = Fabricate(:topic, entity_user: entity_user)
    @topic_user = Fabricate(:topic_user, topic: @topic, entity_user: entity_user)
    @me = entity_user.user
    @valid_params = {id: @topic.to_param, access_token: @me.access_token}
  end
  
  describe "create" do

    it "with valid params" do
      eu = Fabricate(:entity_user, user: @me)
      Api::V1::TopicPresenter.should_receive(:new).with(kind_of(Topic))
      Topic.any_instance.should_receive(:entity_user_join)
      params = {access_token: @me.access_token,
                topic: {entity_user_id: eu.id,
                        title: Faker::Lorem.words(1).join,
                        number: rand(999).to_s
                        }
                }
      get :create, params
      response.status.should == 200
    end
    
  end

  describe "show" do

    it "with valid params" do
      Api::V1::TopicPresenter.should_receive(:new).with(@topic)
      get :show, @valid_params
      response.status.should == 200
    end
    
  end

  describe "posts" do

    it "with valid params" do
      Api::V1::PostPresenter.should_receive(:array).with([])
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

  describe "join" do

    it "works" do
      #Topic.any_instance.should_receive(:user_join)
      post :join, @valid_params
      response.body.should == 'true'
      response.status.should == 200
    end
    
  end

  describe "leave" do

    it "works" do
      #Topic.any_instance.should_receive(:user_leave)
      post :leave, @valid_params
      response.body.should == 'true'
      response.status.should == 200
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
