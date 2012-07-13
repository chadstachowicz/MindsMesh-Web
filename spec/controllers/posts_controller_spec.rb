require 'spec_helper'

describe PostsController do

  def valid_attributes
    { text: Faker::Lorem.sentence }
  end

  before do
    topic_user = Fabricate(:topic_user, user: current_user_master)
    @post = Fabricate(:post, topic: topic_user.topic, user: topic_user.user)
    stub!(:current_user).and_return(current_user_master)
  end

  describe "GET index" do
    it "assigns all posts as @posts" do
      get :index, {}, valid_session
      assigns(:posts).should eq([@post])
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      get :show, {:id => @post.to_param}, valid_session
      assigns(:post).should eq(@post)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested post" do
        # Assuming there are no other posts in the database, this
        # specifies that the Post created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Post.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => @post.to_param, :post => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested post as @post" do
        put :update, {:id => @post.to_param, :post => valid_attributes}, valid_session
        assigns(:post).should eq(@post)
      end

      xit "redirects to the post" do
        put :update, {:id => @post.to_param, :post => valid_attributes}, valid_session
        response.should redirect_to(@post)
      end
    end

    describe "with invalid params" do
      xit "assigns the post as @post" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        Post.any_instance.stub(:errors).and_return(:some => ["errors"])
        put :update, {:id => @post.to_param, :post => {}}, valid_session
        assigns(:post).should eq(@post)
      end

      xit "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        Post.any_instance.stub(:errors).and_return(:some => ["errors"])
        put :update, {:id => @post.to_param, :post => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested post" do
      expect {
        delete :destroy, {:id => @post.to_param}, valid_session
      }.to change(Post, :count).by(-1)
    end

    it "renders nothing" do
      delete :destroy, {:id => @post.to_param}, valid_session
      response.body.should be_blank
    end
  end

  describe "POST create_reply" do

    describe "valid params" do
      it "creates a reply" do
        expect {
          post :create_reply, {id: @post.to_param, reply: {text: Faker::Lorem.sentence}}, valid_session
        }.to change(Reply, :count).by(1)
      end
      it "creates a reply associated with @post" do
        expect {
          post :create_reply, {id: @post.to_param, reply: {text: Faker::Lorem.sentence}}, valid_session
        }.to change(@post.replies, :count).by(1)
      end
      it "creates a reply associated with current_user" do
        expect {
          post :create_reply, {id: @post.to_param, reply: {text: Faker::Lorem.sentence}}, valid_session
        }.to change(current_user.replies, :count).by(1)
      end

      it "renders the post html" do
        t = Faker::Lorem.sentence
        post :create_reply, {id: @post.to_param, reply: {text: t}}, valid_session
        response.should render_template("replies/_reply")
      end
    end

    describe "invalid params" do
      it "status should be 422" do
        post :create_reply, {id: @post.to_param}, valid_session
        response.status.should == 422
      end
    end

  end

  describe "PUT like" do

    it "creates like" do
      -> {
        put :like, {:id => @post.to_param}, valid_session
      }.should change(Like, :count).by(1)
    end

    it "creates like assiciated with @post" do
      -> {
        put :like, {:id => @post.to_param}, valid_session
      }.should change(@post.likes, :count).by(1)
    end

    it "creates like assiciated with current_user" do
      -> {
        put :like, {:id => @post.to_param}, valid_session
      }.should change(current_user.likes, :count).by(1)
    end

    it "can't like @post twice" do
      -> {
        put :like, {:id => @post.to_param}, valid_session
        put :like, {:id => @post.to_param}, valid_session
      }.should change(Like, :count).by(1)
    end

    it "renders current likes count" do
      put :like, {:id => @post.to_param}, valid_session
      response.body.should == @post.reload.likes.size.to_s
    end

  end

end