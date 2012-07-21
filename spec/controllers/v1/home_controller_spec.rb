require 'spec_helper'

describe V1::HomeController do

  describe "posts family" do
    before do
      @topic_user = Fabricate(:topic_user)
      @current_user = @topic_user.user
    end

    def valid_params
      {access_token: @current_user.id}
    end

    describe "posts" do

      it "without posts" do
        V1::PostPresenter.should_receive(:array).with([])
        get :posts, valid_params
        response.status.should == 200
        #assigns(:posts).should == []
      end

      it "with one post" do
        post = Fabricate(:post, user: @topic_user.user, topic: @topic_user.topic)
        V1::PostPresenter.should_receive(:array).with([post])
        get :posts, valid_params
        response.status.should == 200
        #assigns(:posts).should == [V1::PostPresenter.new(post)]
        #I don't think it's necessary to validate the json rendering
      end

    end

    describe "posts_with_parents" do

      it "with one post" do
        post = Fabricate(:post, user: @topic_user.user, topic: @topic_user.topic)
        get :posts_with_parents, valid_params
        response.status.should == 200
        response.body.should include @topic_user.user.name
        response.body.should include @topic_user.topic.name
        #assigns(:posts).should == [V1::PostPresenter.new(post)]
        #I don't think it's necessary to validate the json rendering
      end
      
    end
  end

  describe "entites family" do

    before do
      @current_user = Fabricate(:user)
    end

    def valid_params
      {access_token: @current_user.id}
    end

    describe "entities" do

      it "works" do

        entities = [
          Fabricate(:entity_user, user: @current_user).entity,
          Fabricate(:entity_user, user: @current_user).entity
        ]

        V1::EntityPresenter.should_receive(:array).with(entities)
        get :entities, valid_params
        response.status.should == 200
        #assigns(:posts).should == [V1::PostPresenter.new(post)]
        #I don't think it's necessary to validate the json rendering
      end

    end

    describe "entities_with_children" do

      it "works" do

        entities = [
          (e1 = Fabricate(:entity_user, user: @current_user).entity),
          (e2 = Fabricate(:entity_user, user: @current_user).entity)
        ]
        topics = []

        entities.each do |e|
          3.times do
            topics << Fabricate(:topic, entity: e)
          end
        end

        topics[2].user_join @current_user

        get :entities_with_children, valid_params
        response.status.should == 200
        response.body.should include e1.name
        response.body.should include e2.name
        response.body.should include 'b_joined'
        #assigns(:posts).should == [V1::PostPresenter.new(post)]
        #I don't think it's necessary to validate the json rendering
      end

    end

  end

end
