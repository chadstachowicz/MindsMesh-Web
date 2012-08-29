require 'spec_helper'

describe Api::V1::HomeController do

  before do
    @topic_user = Fabricate(:topic_user)
    @me = @topic_user.user
    @valid_params = {access_token: @me.access_token}
  end

  describe "posts family" do

    describe "posts" do

      it "without posts" do
        Api::V1::PostPresenter.should_receive(:array).with([])
        get :posts, @valid_params
        response.status.should == 200
        #assigns(:posts).should == []
      end

      it "with one post" do
        post = Fabricate(:post, user: @topic_user.user, topic: @topic_user.topic)
        Api::V1::PostPresenter.should_receive(:array).with([post])
        get :posts, @valid_params
        response.status.should == 200
        #assigns(:posts).should == [V1::PostPresenter.new(post)]
        #I don't think it's necessary to validate the json rendering
      end

    end

    describe "posts_with_parents" do

      it "with one post" do
        post = Fabricate(:post, user: @topic_user.user, topic: @topic_user.topic)
        get :posts_with_parents, @valid_params
        response.status.should == 200
        response.body.should include @topic_user.user.name
        response.body.should include @topic_user.topic.name
        #assigns(:posts).should == [V1::PostPresenter.new(post)]
        #I don't think it's necessary to validate the json rendering
      end
      
    end
  end

  describe "entities family" do

    describe "entities" do

      it "works" do
        Api::V1::EntityPresenter.should_receive(:array)
        get :entities, @valid_params
        response.status.should == 200
        #assigns(:posts).should == [V1::PostPresenter.new(post)]
        #I don't think it's necessary to validate the json rendering
      end

    end

    describe "entities_with_children" do

      it "works" do
        eu = Fabricate(:entity_user, user: @me)
        entities = [eu.entity]
        topics = []

        entities.each do |e|
          3.times do
            topics << Fabricate(:topic, entity_user: eu)
          end
        end

        get :entities_with_children, @valid_params
        response.status.should == 200
        response.body.should include entities.first.name
        response.body.should include 'b_joined'
        response.body.should include 'entity_user'
        #assigns(:posts).should == [V1::PostPresenter.new(post)]
        #I don't think it's necessary to validate the json rendering
      end

    end

  end

  describe "topics" do

    describe "topics" do

      it "works" do
        Api::V1::TopicPresenter.should_receive(:array).with([@topic_user.topic])
        get :topics, @valid_params
        response.status.should == 200
      end

    end

    describe "search_topics" do

      it "works" do
        User.any_instance.should_not_receive(:search_topics).with('a')
        get :search_topics, @valid_params.merge(q: 'a')
        response.status.should == 200
      end

    end
    
  end

  describe "POST 'create_entity_request'" do
    it "should create an EUR" do
      Fabricate(:entity, slug: 'uncc')

      prms = {email: "#{Faker::Internet.user_name}@uncc.edu"}

      expect {
        get 'create_entity_request', @valid_params.merge(prms)
        response.body.should include 'message'
        response.status.should == 200
      }.to change(@me.entity_user_requests, :count).by(1)
    end
    it "only works for uncc" do
      Fabricate(:entity, slug: 'uncc')

      prms = {email: "#{Faker::Internet.user_name}@lalala.edu"}

      expect {
        get 'create_entity_request', @valid_params.merge(prms)
        response.body.should include 'message'
        response.status.should == 200
      }.to_not change(@me.entity_user_requests, :count)
    end
  end

end
