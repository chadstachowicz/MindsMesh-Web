class EntitiesController < ApplicationController
  respond_to :html, :json, :js
  load_and_authorize_resource

  # GET /entities
  def index
    page_limit = params[:page_limit] || 10
    q = "%#{params[:q].gsub(' ', '%')}%"
    @entities = @entities.where("UPPER(name) lIKE UPPER(:q)", q: q).limit(page_limit)
    respond_with(@entities)
  end

  # GET /entities/1
  def show
    respond_with(@entity)
  end

  # GET /entities/new
  def new
    respond_with(@entity)
  end

  # GET /entities/1/edit
  def edit
    respond_with(@entity)
  end

  # POST /entities
  def create
    if @entity.save
      flash[:notice] = "Entity successfully created."
    end
    respond_with(@entity, location: @entity)
  end

  # PUT /entities/1
  def update
    #@entity.update_attributes(params[:entity])
    if @entity.update_attributes(params[:entity])
      flash[:notice] = "Entity successfully updated."
    end
    respond_with(@entity, location: @entity)
  end

  # DELETE /entities/1
  def destroy
    @entity.destroy
    respond_with(@entity)
  end
end
