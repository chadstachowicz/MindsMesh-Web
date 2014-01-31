class GroupsController < ApplicationController
  respond_to :html, :json#, :xml
  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /groups
  def index
  end

  # GET /groups/1
  def show
      @group_user  = @group.group_users.where(user_id: current_user.id).first
      @group_users = @group.group_users.where('role_i is null or role_i = 0').limit(10)
      @admins = @group.group_users.where(:role_i => 1)
      @posts         = @group.posts.as_feed(params.slice(:limit, :before))
      @post = Post.new
      @type = 'group'
      respond_with(@group)
  end

  # GET /groups/new
  def new
      @group.entity_user_join(@group.entity_user,true)
      flash[:notice] = "Group successfully created."
      respond_with(@group)
  end
    
    # PUT /topics/1/join
    def join
        eu = EntityUser.eu(@group.entity_id, current_user.id)
        @group.entity_user_join(eu)
        redirect_to @group
    end
    
    # PUT /topics/1/leave
    def leave
        eu = EntityUser.eu(@group.entity_id, current_user.id)
        @group.entity_user_leave(eu)
        redirect_to @group
    end
    
    # GET /topics/1/more_posts.js
    def more_posts
        @posts = @topic.posts.as_feed(params.slice(:limit, :before))
        render '/posts/more_posts', layout: false
    end

  # POST /groups
  def create
    if @group.save
      @group.entity_user_join(@group.entity_user,true)
      redirect_to @group, notice: 'Group was created.'
    else
      render action: "new"
    end
  end

  # GET /groups/1/edit
  def edit
  end

  # PUT /groups/1
  def update
    if @group.update_attributes(params[:group])
      redirect_to @group, notice: 'Group was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    redirect_to groups_url
  end

end

=begin
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new
    #beyond simple html, use show code
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])

    #beyond simple html
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end