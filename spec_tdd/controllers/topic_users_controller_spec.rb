require 'spec_helper'

describe TopicUsersController do
=begin
  before do
    @topic       = Fabricate(:topic)
    @entity_user = Fabricate(:entity_user, entity: @topic.entity)
  end

  def valid_attributes
    {topic_id: @topic.id, entity_user_id: @entity_user.id}
  end

  describe "GET index" do
    it "assigns all topic_users as @topic_users" do
      #topic_user = TopicUser.create! valid_attributes
      get :index, {}, valid_session
      response.status == 200
    end
  end

  describe "GET show" do
    it "assigns the requested topic_user as @topic_user" do
      topic_user = TopicUser.create! valid_attributes
      get :show, {:id => topic_user.to_param}, valid_session
      assigns(:topic_user).should eq(topic_user)
    end
  end

  describe "GET new" do
    it "assigns a new topic_user as @topic_user" do
      get :new, {}, valid_session
      assigns(:topic_user).should be_a_new(TopicUser)
    end
  end

  describe "GET edit" do
    it "assigns the requested topic_user as @topic_user" do
      topic_user = TopicUser.create! valid_attributes
      get :edit, {:id => topic_user.to_param}, valid_session
      assigns(:topic_user).should eq(topic_user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TopicUser" do
        expect {
          post :create, {:topic_user => valid_attributes}, valid_session
        }.to change(TopicUser, :count).by(1)
      end

      it "assigns a newly created topic_user as @topic_user" do
        post :create, {:topic_user => valid_attributes}, valid_session
        assigns(:topic_user).should be_a(TopicUser)
        assigns(:topic_user).should be_persisted
      end

      it "redirects to the created topic_user" do
        post :create, {:topic_user => valid_attributes}, valid_session
        response.should redirect_to(TopicUser.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved topic_user as @topic_user" do
        # Trigger the behavior that occurs when invalid params are submitted
        TopicUser.any_instance.stub(:save).and_return(false)
        TopicUser.any_instance.stub(:errors).and_return(:some => ["errors"])
        post :create, {:topic_user => {}}, valid_session
        assigns(:topic_user).should be_a_new(TopicUser)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TopicUser.any_instance.stub(:save).and_return(false)
        TopicUser.any_instance.stub(:errors).and_return(:some => ["errors"])
        post :create, {:topic_user => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested topic_user" do
        topic_user = TopicUser.create! valid_attributes
        # Assuming there are no other topic_users in the database, this
        # specifies that the TopicUser created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        TopicUser.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => topic_user.to_param, :topic_user => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested topic_user as @topic_user" do
        topic_user = TopicUser.create! valid_attributes
        put :update, {:id => topic_user.to_param, :topic_user => valid_attributes}, valid_session
        assigns(:topic_user).should eq(topic_user)
      end

      it "redirects to the topic_user" do
        topic_user = TopicUser.create! valid_attributes
        put :update, {:id => topic_user.to_param, :topic_user => valid_attributes}, valid_session
        response.should redirect_to(topic_user)
      end
    end

    describe "with invalid params" do
      it "assigns the topic_user as @topic_user" do
        topic_user = TopicUser.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TopicUser.any_instance.stub(:save).and_return(false)
        TopicUser.any_instance.stub(:errors).and_return(:some => ["errors"])
        put :update, {:id => topic_user.to_param, :topic_user => {}}, valid_session
        assigns(:topic_user).should eq(topic_user)
      end

      it "re-renders the 'edit' template" do
        topic_user = TopicUser.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TopicUser.any_instance.stub(:save).and_return(false)
        TopicUser.any_instance.stub(:errors).and_return(:some => ["errors"])
        put :update, {:id => topic_user.to_param, :topic_user => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested topic_user" do
      topic_user = TopicUser.create! valid_attributes
      expect {
        delete :destroy, {:id => topic_user.to_param}, valid_session
      }.to change(TopicUser, :count).by(-1)
    end

    it "redirects to the topic_users list" do
      topic_user = TopicUser.create! valid_attributes
      delete :destroy, {:id => topic_user.to_param}, valid_session
      response.should redirect_to(topic_users_url)
    end
  end
=end
end