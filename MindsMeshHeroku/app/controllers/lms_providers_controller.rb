class LmsProvidersController < ApplicationController
  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /lms_providers
  def index
  end

  # GET /lms_providers/1
  def show
  end

  # GET /lms_providers/new
  def new
  end

  # POST /lms_providers
  def create
    if @lms_provider.save
      redirect_to @lms_provider, notice: 'Lms provider was created.'
    else
      render action: "new"
    end
  end

  # GET /lms_providers/1/edit
  def edit
  end

  # PUT /lms_providers/1
  def update
    if @lms_provider.update_attributes(params[:lms_provider])
      redirect_to @lms_provider, notice: 'Lms provider was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /lms_providers/1
  def destroy
    @lms_provider.destroy
    redirect_to lms_providers_url
  end

end

=begin
  # GET /lms_providers
  # GET /lms_providers.json
  def index
    @lms_providers = LmsProvider.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @lms_providers }
    end
  end

  # GET /lms_providers/1
  # GET /lms_providers/1.json
  def show
    @lms_provider = LmsProvider.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @lms_provider }
    end
  end

  # GET /lms_providers/new
  # GET /lms_providers/new.json
  def new
    @lms_provider = LmsProvider.new
    #beyond simple html, use show code
  end

  # GET /lms_providers/1/edit
  def edit
    @lms_provider = LmsProvider.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /lms_providers
  # POST /lms_providers.json
  def create
    @lms_provider = LmsProvider.new(params[:lms_provider])

    #beyond simple html
    respond_to do |format|
      if @lms_provider.save
        format.html { redirect_to @lms_provider, notice: 'Lms provider was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @lms_provider, status: :created, location: @lms_provider }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @lms_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lms_providers/1
  # PUT /lms_providers/1.json
  def update
    @lms_provider = LmsProvider.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @lms_provider.update_attributes(params[:lms_provider])
        format.html { redirect_to @lms_provider, notice: 'Lms provider was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @lms_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lms_providers/1
  # DELETE /lms_providers/1.json
  def destroy
    @lms_provider = LmsProvider.find(params[:id])
    @lms_provider.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to lms_providers_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end