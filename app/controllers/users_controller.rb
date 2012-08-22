class UsersController < ApplicationController
  respond_to :html#, :json, :xml
  load_and_authorize_resource

  # GET /users
  def index
    @users = @users.order(:id)
    respond_with()
  end

  # GET /users/1
  def show
    @posts = @user.posts.as_feed(params.slice(:limit, :before))
    @topic_users = @user.topic_users
    respond_with(@user)
  end

  # GET /users/1/more_posts.js
  def more_posts
    @posts = @user.posts.as_feed(params.slice(:limit, :before))
    render '/posts/more_posts', layout: false
  end

  # GET /users/1/edit
  def edit
    respond_with(@user)
  end

  # PUT /users/1
  def update
    #@user.update_attributes(params[:user])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User successfully updated."
    end
    respond_with(@user, location: @user)
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_with(@user)
  end
end
