require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PostsController do

  def valid_attributes
    { text: Faker::Lorem.sentence }
  end

  before(:each) do
    @post = Fabricate(:post, topic_user: Fabricate(:topic_user, user: current_user_master), user: current_user_master)
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

  describe "GET edit" do
    it "assigns the requested post as @post" do
      get :edit, {:id => @post.to_param}, valid_session
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

      it "redirects to the post" do
        put :update, {:id => @post.to_param, :post => valid_attributes}, valid_session
        response.should redirect_to(@post)
      end
    end

    describe "with invalid params" do
      it "assigns the post as @post" do
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        Post.any_instance.stub(:errors).and_return(:some => ["errors"])
        put :update, {:id => @post.to_param, :post => {}}, valid_session
        assigns(:post).should eq(@post)
      end

      it "re-renders the 'edit' template" do
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

    it "redirects to the posts list" do
      delete :destroy, {:id => @post.to_param}, valid_session
      response.should redirect_to(posts_url)
    end
  end

  describe "POST replies" do

    describe "valid params" do
      it "creates a reply" do
        expect {
          post :replies, {id: @post.to_param, reply: {text: Faker::Lorem.sentence}}, valid_session
        }.to change(Reply, :count).by(1)
      end
      it "creates a reply associated with @post" do
        expect {
          post :replies, {id: @post.to_param, reply: {text: Faker::Lorem.sentence}}, valid_session
        }.to change(@post.replies, :count).by(1)
      end
      it "creates a reply associated with current_user" do
        expect {
          post :replies, {id: @post.to_param, reply: {text: Faker::Lorem.sentence}}, valid_session
        }.to change(current_user.replies, :count).by(1)
      end

      it "redirects to the related post" do
        post :replies, {id: @post.to_param, reply: {text: Faker::Lorem.sentence}}, valid_session
        response.should redirect_to(@post)
      end
    end

    describe "invalid params throw exception resulting in 500 error" do
      it "without text" do
        -> {
          post :replies, {id: @post.to_param, reply: {}}, valid_session
        }.should raise_error(ActiveRecord::RecordInvalid)
      end
      it "without reply" do
        -> {
          post :replies, {id: @post.to_param}, valid_session
        }.should raise_error(ActiveRecord::RecordInvalid)
      end
    end

  end

end