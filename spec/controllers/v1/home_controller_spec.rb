require 'spec_helper'

describe V1::HomeController do

  before do
    @topic_user = Fabricate(:topic_user)
    @me = @topic_user.user
    @valid_params = {access_token: @me.access_token}
  end

  describe "posts family" do

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
        V1::EntityPresenter.should_receive(:array)
        get :entities, @valid_params
        response.status.should == 200
        #assigns(:posts).should == [V1::PostPresenter.new(post)]
        #I don't think it's necessary to validate the json rendering
      end

    end

    describe "entities_with_children" do

      it "works" do

        entities = @me.entities
        topics = []

        entities.each do |e|
          3.times do
            topics << Fabricate(:topic, entity: e)
          end
        end

        topics[2].user_join @me

        get :entities_with_children, @valid_params
        response.status.should == 200
        response.body.should include entities.first.name
        response.body.should include 'b_joined'
        #assigns(:posts).should == [V1::PostPresenter.new(post)]
        #I don't think it's necessary to validate the json rendering
      end

    end

  end

  describe "topics" do

    describe "topics" do

      it "works" do
        V1::TopicPresenter.should_receive(:array).with([@topic_user.topic])
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

end
