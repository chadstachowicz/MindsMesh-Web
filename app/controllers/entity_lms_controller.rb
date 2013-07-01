class EntityLmsController < ApplicationController
  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /entity_lms
  def index
  end

  # GET /entity_lms/1
  def show
  end

  # GET /entity_lms/new
  def new
  end

  # POST /entity_lms
  def create
    if @entity_lm.save
      redirect_to @entity_lm, notice: 'Entity lm was created.'
    else
      render action: "new"
    end
  end

  # GET /entity_lms/1/edit
  def edit
  end

  # PUT /entity_lms/1
  def update
    if @entity_lm.update_attributes(params[:entity_lm])
      redirect_to @entity_lm, notice: 'Entity lm was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /entity_lms/1
  def destroy
    @entity_lm.destroy
    redirect_to entity_lms_url
  end

end

=begin
  # GET /entity_lms
  # GET /entity_lms.json
  def index
    @entity_lms = EntityLm.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @entity_lms }
    end
  end

  # GET /entity_lms/1
  # GET /entity_lms/1.json
  def show
    @entity_lm = EntityLm.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @entity_lm }
    end
  end

  # GET /entity_lms/new
  # GET /entity_lms/new.json
  def new
    @entity_lm = EntityLm.new
    #beyond simple html, use show code
  end

  # GET /entity_lms/1/edit
  def edit
    @entity_lm = EntityLm.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /entity_lms
  # POST /entity_lms.json
  def create
    @entity_lm = EntityLm.new(params[:entity_lm])

    #beyond simple html
    respond_to do |format|
      if @entity_lm.save
        format.html { redirect_to @entity_lm, notice: 'Entity lm was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @entity_lm, status: :created, location: @entity_lm }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @entity_lm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entity_lms/1
  # PUT /entity_lms/1.json
  def update
    @entity_lm = EntityLm.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @entity_lm.update_attributes(params[:entity_lm])
        format.html { redirect_to @entity_lm, notice: 'Entity lm was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @entity_lm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entity_lms/1
  # DELETE /entity_lms/1.json
  def destroy
    @entity_lm = EntityLm.find(params[:id])
    @entity_lm.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to entity_lms_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end