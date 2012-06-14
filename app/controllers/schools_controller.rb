class SchoolsController < ApplicationController
  before_filter :must_user
  
  respond_to :html#, :json, :xml

  load_and_authorize_resource

  # GET /schools
  def index
    @schools = School.all
    respond_with(@schools)
  end

  # GET /schools/1
  def show
    respond_with(@school)
  end

  # GET /schools/new
  def new
    respond_with(@school)
  end

  # GET /schools/1/edit
  def edit
    respond_with(@school)
  end

  # POST /schools
  def create
    if @school.save
      flash[:notice] = "School successfully created."
    end
    respond_with(@school, location: @school)
  end

  # PUT /schools/1
  def update
    #@school.update_attributes(params[:school])
    if @school.update_attributes(params[:school])
      flash[:notice] = "School successfully updated."
    end
    respond_with(@school, location: @school)
  end

  # DELETE /schools/1
  def destroy
    @school.destroy
    respond_with(@school)
  end
end
