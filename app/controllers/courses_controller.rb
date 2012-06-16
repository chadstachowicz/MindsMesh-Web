class CoursesController < ApplicationController
  respond_to :html#, :json, :xml

  load_and_authorize_resource

  # GET /courses
  def index
    @courses = Course.all
    respond_with(@courses)
  end

  # GET /courses/1
  def show
    @course = Course.find(params[:id])
    respond_with(@course)
  end

  # GET /courses/new
  def new
    @course = Course.new
    respond_with(@course)
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
    respond_with(@course)
  end

  # POST /courses
  def create
    @course = Course.create(params[:course])

    if @course.persisted?
      flash[:notice] = "Course successfully created."
    end
    respond_with(@course, location: @course)
  end

  # PUT /courses/1
  def update
    @course = Course.find(params[:id])
    
    #@course.update_attributes(params[:course])
    if @course.update_attributes(params[:course])
      flash[:notice] = "Course successfully updated."
    end
    respond_with(@course, location: @course)
  end

  # DELETE /courses/1
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    respond_with(@course)
  end
end
