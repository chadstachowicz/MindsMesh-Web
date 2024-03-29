
# MindsMesh, Inc. (c) 2012-2013

class UsersController < ApplicationController
  respond_to :html#, :json, :xml

  load_and_authorize_resource

  layout 'datatables', only: [:index]

  # GET /users
  def index
    respond_with(@users) do |format|
      format.json { render json: UsersDatatable.new(view_context) }
    end
  end
    
  def new
      render :layout => 'pages'
  end

  # GET /users/1
  def show
      topic_ids = current_user.topic_users.map(&:topic_id)
      group_ids = current_user.group_users.map(&:group_id)
    @posts = Post.where('(user_id in (:user_ids) and (topic_id is null or topic_id in (:topic_ids)) and (group_id is null or group_id in (:group_ids)))', :user_ids => @user.id, :topic_ids => topic_ids,:group_ids => group_ids).as_feed(params.slice(:limit, :before))
    @topic_users = @user.topic_users
    @user_follows = @current_user.user_follows.where(:follow_id => @user.id)
    if @user.entity_user_requests.first.nil?
        @email = current_user.email
    else
        @email = @user.entity_user_requests.first.email
    end
    respond_with(@user)
  end
  
  # GET /users/1/more_posts.js
  def more_posts
    @posts = @user.posts.as_feed(params.slice(:limit, :before))
    render '/posts/more_posts', layout: false
  end

  # GET /users/1/edit
  def edit
    @schools = @user.entity_users
    @topics = @user.topic_users
    @groups = @user.group_users
    respond_with(@user)
  end

  # PUT /users/1
  def update
    #@user.update_attributes(params[:user])
    if @user.update_attributes(params[:user])
       sign_in @user, :bypass => true
      flash[:notice] = "User successfully updated."
    end
    respond_with(@user, location: @user)
  end

  # PUT /users/1/follow
  def follow
    UserFollow.create user_id: @current_user.id.to_i, follow_id: @user.id.to_i
    redirect_to @user
  end

  # PUT /users/1/unfollow
  def unfollow
    uf = UserFollow.where(:user_id => @current_user.id.to_i, :follow_id => @user.id.to_i)
    uf.destroy(uf)
    redirect_to @user
  end
    
  # DELETE /users/1
  def destroy
    @user.destroy
    respond_with(@user)
  end
    
  def import
      User.import(params[:file])
      redirect_to root_url, notice: "Users imported."
  end
end
