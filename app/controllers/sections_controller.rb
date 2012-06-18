class SectionsController < ApplicationController
  respond_to :html#, :json, :xml

  load_and_authorize_resource

  # GET /sections
  def index
    @sections = Section.all
    respond_with(@sections)
  end

  # GET /sections/1
  def show
    @section_user  = @section.section_users.where(user_id: current_user.id).first
    @section_users = @section.section_users.order("role DESC").limit(10)
    @posts         = @section.posts.order("id DESC").limit(10)
    @post = Post.new
    respond_with(@section)
  end

  # PUT /sections/1/join
  def join
    @section_user = @section.section_users.where(user_id: current_user.id).first_or_initialize
    if @section_user.new_record?
      @section_user.save!
      flash[:notice] = "you joined the section"
    else
      @section_user.destroy
      flash[:notice] = "you left the section"
    end
    redirect_to @section
  end

  def create_post
    @section_user  = @section.section_users.where(user_id: current_user.id).first
    @post = @section_user.posts.build(params[:post])
    if @post.save
      flash[:notice] = "Post successfully created."
      redirect_to @section
    else
      @section_users = @section.section_users.order("role DESC").limit(10)
      @posts         = @section.posts.order("id DESC").limit(10)
      render :show
    end
  end

  # GET /sections/new
  def new
    respond_with(@section)
  end

  # GET /sections/1/edit
  def edit
    respond_with(@section)
  end

  # POST /sections
  def create
    if @section.save
      flash[:notice] = "Section successfully created."
    end
    respond_with(@section, location: @section)
  end

  # PUT /sections/1
  def update
    if @section.update_attributes(params[:section])
      flash[:notice] = "Section successfully updated."
    end
    respond_with(@section, location: @section)
  end

  # DELETE /sections/1
  def destroy
    @section.destroy
    respond_with(@section)
  end
end
