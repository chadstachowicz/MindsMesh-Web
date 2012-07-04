class TopicsController < ApplicationController
  respond_to :html#, :json, :xml

  load_and_authorize_resource except: [:more_posts]
  load_resource only: [:more_posts]

  # GET /topics
  def index
    @topics = Topic.all
    respond_with(@topics)
  end

  # GET /topics/1
  def show
    @topic_user  = @topic.topic_users.where(user_id: current_user.id).first
    @topic_users = @topic.topic_users.order("role DESC").limit(10)
    @posts         = @topic.posts.as_feed(params.slice(:limit, :before))
    @post = Post.new
    respond_with(@topic)
  end

  # PUT /topics/1/join
  def join
    @topic_user = @topic.topic_users.where(user_id: current_user.id).first_or_initialize
    if @topic_user.new_record?
      @topic_user.save!
      flash[:notice] = "you joined the topic"
    else
      @topic_user.destroy
      flash[:notice] = "you left the topic"
    end
    redirect_to @topic
  end

  # GET /topics/1/more_posts.js
  def more_posts
    authorize! :read_posts, @topic #TODO: test this
    @posts = @topic.posts.as_feed(params.slice(:limit, :before))
    render '/posts/more_posts', layout: false
  end

  # GET /topics/new
  def new
    respond_with(@topic)
  end

  # GET /topics/1/edit
  def edit
    respond_with(@topic)
  end

  # POST /topics
  def create
    if @topic.save
      flash[:notice] = "Topic successfully created."
    end
    respond_with(@topic, location: @topic)
  end

  # PUT /topics/1
  def update
    if @topic.update_attributes(params[:topic])
      flash[:notice] = "Topic successfully updated."
    end
    respond_with(@topic, location: @topic)
  end

  # DELETE /topics/1
  def destroy
    @topic.destroy
    respond_with(@topic)
  end
end
