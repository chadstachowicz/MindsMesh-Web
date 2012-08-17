class TopicUsersController < ApplicationController
=begin

  respond_to :html#, :json, :xml

  load_and_authorize_resource

  # GET /topic_users
  def index
    @topic_users = TopicUser.all
    respond_with(@topic_users)
  end

  # GET /topic_users/1
  def show
    respond_with(@topic_user)
  end

  # GET /topic_users/new
  def new
    respond_with(@topic_user)
  end

  # GET /topic_users/1/edit
  def edit
    respond_with(@topic_user)
  end

  # POST /topic_users
  def create
    if @topic_user.save
      flash[:notice] = "Topic user successfully created."
    end
    respond_with(@topic_user, location: @topic_user)
  end

  # PUT /topic_users/1
  def update
    if @topic_user.update_attributes(params[:topic_user])
      flash[:notice] = "Topic user successfully updated."
    end
    respond_with(@topic_user, location: @topic_user)
  end

  # DELETE /topic_users/1
  def destroy
    @topic_user.destroy
    respond_with(@topic_user)
  end
=end
end
