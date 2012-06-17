class SectionUsersController < ApplicationController
  respond_to :html#, :json, :xml

  load_and_authorize_resource

  # GET /section_users
  def index
    @section_users = SectionUser.all
    respond_with(@section_users)
  end

  # GET /section_users/1
  def show
    respond_with(@section_user)
  end

  # GET /section_users/new
  def new
    respond_with(@section_user)
  end

  # GET /section_users/1/edit
  def edit
    respond_with(@section_user)
  end

  # POST /section_users
  def create
    if @section_user.save
      flash[:notice] = "Section user successfully created."
    end
    respond_with(@section_user, location: @section_user)
  end

  # PUT /section_users/1
  def update
    if @section_user.update_attributes(params[:section_user])
      flash[:notice] = "Section user successfully updated."
    end
    respond_with(@section_user, location: @section_user)
  end

  # DELETE /section_users/1
  def destroy
    @section_user.destroy
    respond_with(@section_user)
  end
end
