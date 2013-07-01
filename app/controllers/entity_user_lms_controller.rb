class EntityUserLmsController < ApplicationController
  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /entity_user_lms
  def index
  end

  # GET /entity_user_lms/1
  def show
  end

  # GET /entity_user_lms/new
  def new
  end

  # POST /entity_user_lms
  def create
    if @entity_user_lm.save
      redirect_to @entity_user_lm, notice: 'Entity user lm was created.'
    else
      render action: "new"
    end
  end

  # GET /entity_user_lms/1/edit
  def edit
  end

  # PUT /entity_user_lms/1
  def update
    if @entity_user_lm.update_attributes(params[:entity_user_lm])
      redirect_to @entity_user_lm, notice: 'Entity user lm was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /entity_user_lms/1
  def destroy
    @entity_user_lm.destroy
    redirect_to entity_user_lms_url
  end

end

=begin
  # GET /entity_user_lms
  # GET /entity_user_lms.json
  def index
    @entity_user_lms = EntityUserLm.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @entity_user_lms }
    end
  end

  # GET /entity_user_lms/1
  # GET /entity_user_lms/1.json
  def show
    @entity_user_lm = EntityUserLm.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @entity_user_lm }
    end
  end

  # GET /entity_user_lms/new
  # GET /entity_user_lms/new.json
  def new
    @entity_user_lm = EntityUserLm.new
    #beyond simple html, use show code
  end

  # GET /entity_user_lms/1/edit
  def edit
    @entity_user_lm = EntityUserLm.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /entity_user_lms
  # POST /entity_user_lms.json
  def create
    @entity_user_lm = EntityUserLm.new(params[:entity_user_lm])

    #beyond simple html
    respond_to do |format|
      if @entity_user_lm.save
        format.html { redirect_to @entity_user_lm, notice: 'Entity user lm was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @entity_user_lm, status: :created, location: @entity_user_lm }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @entity_user_lm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entity_user_lms/1
  # PUT /entity_user_lms/1.json
  def update
    @entity_user_lm = EntityUserLm.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @entity_user_lm.update_attributes(params[:entity_user_lm])
        format.html { redirect_to @entity_user_lm, notice: 'Entity user lm was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @entity_user_lm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entity_user_lms/1
  # DELETE /entity_user_lms/1.json
  def destroy
    @entity_user_lm = EntityUserLm.find(params[:id])
    @entity_user_lm.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to entity_user_lms_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end