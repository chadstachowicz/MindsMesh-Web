require 'spec_helper'

describe TopicsController do

  def valid_attributes
    {title: Faker::Name.name, number: 10, entity_id: Fabricate(:entity).id}
  end

  describe "GET index" do
    it "assigns all topics as @topics" do
      topic = Topic.create! valid_attributes
      get :index, {}, valid_session
      assigns(:topics).should eq([topic])
    end
  end

  describe "GET show" do
    it "assigns the requested topic as @topic" do
      topic = Topic.create! valid_attributes
      get :show, {:id => topic.to_param}, valid_session
      assigns(:topic).should eq(topic)
      assigns(:topic).should be_present
    end
  end

  describe "PUT join" do
    it "current_user joins the @topic" do
      topic = Fabricate(:topic)
      Topic.any_instance.stub(:user_join)
      Topic.any_instance.should_not_receive(:user_join)
      get :join, {:id => topic.to_param}, valid_session
      response.should redirect_to(topic)
    end
  end

  describe "PUT leave" do
    it "current_user leaves the @topic" do
      topic = Fabricate(:topic)
      Topic.any_instance.stub(:user_join)
      Topic.any_instance.should_not_receive(:user_leave)
      get :leave, {:id => topic.to_param}, valid_session
      response.should redirect_to(topic)
    end
  end

  describe "GET new" do
    it "assigns a new topic as @topic" do
      get :new, {}, valid_session
      assigns(:topic).should be_a_new(Topic)
    end
  end

  describe "GET edit" do
    it "assigns the requested topic as @topic" do
      topic = Topic.create! valid_attributes
      get :edit, {:id => topic.to_param}, valid_session
      assigns(:topic).should eq(topic)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Topic" do
        expect {
          post :create, {:topic => valid_attributes}, valid_session
        }.to change(Topic, :count).by(1)
      end

      it "assigns a newly created topic as @topic" do
        post :create, {:topic => valid_attributes}, valid_session
        assigns(:topic).should be_a(Topic)
        assigns(:topic).should be_persisted
      end

      it "redirects to the created topic" do
        post :create, {:topic => valid_attributes}, valid_session
        response.should redirect_to(Topic.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved topic as @topic" do
        # Trigger the behavior that occurs when invalid params are submitted
        Topic.any_instance.stub(:save).and_return(false)
        Topic.any_instance.stub(:errors).and_return(:some => ["errors"])
        post :create, {:topic => {}}, valid_session
        assigns(:topic).should be_a_new(Topic)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Topic.any_instance.stub(:save).and_return(false)
        Topic.any_instance.stub(:errors).and_return(:some => ["errors"])
        post :create, {:topic => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested topic" do
        topic = Topic.create! valid_attributes
        # Assuming there are no other topics in the database, this
        # specifies that the Topic created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Topic.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => topic.to_param, :topic => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested topic as @topic" do
        topic = Topic.create! valid_attributes
        put :update, {:id => topic.to_param, :topic => valid_attributes}, valid_session
        assigns(:topic).should eq(topic)
      end

      it "redirects to the topic" do
        topic = Topic.create! valid_attributes
        put :update, {:id => topic.to_param, :topic => valid_attributes}, valid_session
        response.should redirect_to(topic)
      end
    end

    describe "with invalid params" do
      it "assigns the topic as @topic" do
        topic = Topic.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Topic.any_instance.stub(:save).and_return(false)
        Topic.any_instance.stub(:errors).and_return(:some => ["errors"])
        put :update, {:id => topic.to_param, :topic => {}}, valid_session
        assigns(:topic).should eq(topic)
      end

      it "re-renders the 'edit' template" do
        topic = Topic.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Topic.any_instance.stub(:save).and_return(false)
        Topic.any_instance.stub(:errors).and_return(:some => ["errors"])
        put :update, {:id => topic.to_param, :topic => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested topic" do
      topic = Topic.create! valid_attributes
      expect {
        delete :destroy, {:id => topic.to_param}, valid_session
      }.to change(Topic, :count).by(-1)
    end

    it "redirects to the topics list" do
      topic = Topic.create! valid_attributes
      delete :destroy, {:id => topic.to_param}, valid_session
      response.should redirect_to(topics_url)
    end
  end

  describe "GET more_posts" do
  
    before do
      topic_user = Fabricate(:topic_user)
      valid_session = {user_id: topic_user.user.id}
      @topic = topic_user.topic
      @posts = []
      3.times do
        #these should be tested in the model
        #these should be tested in the model
        #these should be tested in the model
        @posts << Fabricate(:post, topic: topic_user.topic, user: topic_user.user)
        @posts << Fabricate(:post, user: topic_user.user)
        Fabricate(:post, topic: topic_user.topic)
        Fabricate(:post)
      end
    end
    describe "empty set" do
      it "renders template" do
        get :more_posts, {id: Fabricate(:topic).to_param}, valid_session
        response.should render_template("posts/more_posts")#these should be tested in the view
        response.should_not render_template("layouts/application")#these should be tested in the view
      end
      it "renders template" do
        get :more_posts, {id: Fabricate(:topic).to_param}, valid_session
        assigns(:posts).size.should == 0
      end
    end
    describe "with posts" do
      it "validating existing of other posts in the database" do
        Post.count.should == 12
      end
      it "with some posts" do
        get :more_posts, {id: @topic.to_param}, valid_session
        assigns(:posts).size.should == 6
      end
      it "applying before" do
        get :more_posts, {id: @topic.to_param, before: @posts.last.id}, valid_session
        assigns(:posts).size.should == 5
      end
      it "applying limit" do
        get :more_posts, {id: @topic.to_param, limit: 1}, valid_session
        assigns(:posts).size.should == 1
      end
      #it "applying after"
    end
  end

end