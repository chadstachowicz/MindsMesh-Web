class TopicsController < ApplicationController
  respond_to :html, :json#, :xml
  load_and_authorize_resource
    

  #untested
  # GET /topics/filter
  def filter
    @q = params[:q]
    my_topic_ids = current_user.topic_ids

    @topics = current_user.search_topics(@q).limit(50)
    @topics.each { |t| t.is_my_topic = my_topic_ids.include?(t.id) }

    render layout: false
  end

    # GET /entities
    def index
        render layout: 'datatables'
    end
    
    # GET /entities/datatable_filter
    def datatable_filter
        render json: TopicsDatatable.new(view_context)
    end

  # GET /topics/1
  def show
    @topic_user  = @topic.topic_users.where(user_id: current_user.id).first
    @topic_users = @topic.topic_users.where('role_i is null or role_i = 0').limit(10)
    @teachers = @topic.topic_users.where(:role_i => 1)
    @posts         = @topic.posts.as_feed(params.slice(:limit, :before))
    @post = Post.new
    @type = 'topic'
    respond_with(@topic)
  end

  # PUT /topics/1/join
  def join
    eu = EntityUser.eu(@topic.entity_id, current_user.id)
    @topic.entity_user_join(eu)
    redirect_to @topic
  end

  # PUT /topics/1/leave
  def leave
    eu = EntityUser.eu(@topic.entity_id, current_user.id)
    @topic.entity_user_leave(eu)
    redirect_to @topic
  end

  # GET /topics/1/more_posts.js
  def more_posts
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
      @topic.entity_user_join(@topic.entity_user)
      flash[:notice] = "Topic successfully created."
    end
    respond_with(@topic)
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
    
    
  def import
    Topic.import(params[:file])
    redirect_to root_url, notice: "Topics imported."
  end
end
