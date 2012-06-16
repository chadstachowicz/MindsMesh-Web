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
    respond_with(@section)
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
