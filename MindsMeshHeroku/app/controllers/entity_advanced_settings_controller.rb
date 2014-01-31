class EntityAdvancedSettingsController < ApplicationController
  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /entity_advanced_settings
  def index
  end

  # GET /entity_advanced_settings/1
  def show
  end

  # GET /entity_advanced_settings/new
  def new
  end

  # POST /entity_advanced_settings
  def create
    if @entity_advanced_setting.save
        redirect_to entity_settings_path(:entity_id => @entity_advanced_setting.entity_id), notice: 'Entity advanced setting was created.'
    else
      render action: "new"
    end
  end

  # GET /entity_advanced_settings/1/edit
  def edit
  end

  # PUT /entity_advanced_settings/1
  def update
    if @entity_advanced_setting.update_attributes(params[:entity_advanced_setting])
      redirect_to entity_settings_path(:entity_id => @entity_advanced_setting.entity_id), notice: 'Entity advanced setting was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /entity_advanced_settings/1
  def destroy
    @entity_advanced_setting.destroy
    redirect_to entity_advanced_settings_url
  end

end

=begin
  # GET /entity_advanced_settings
  # GET /entity_advanced_settings.json
  def index
    @entity_advanced_settings = EntityAdvancedSetting.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @entity_advanced_settings }
    end
  end

  # GET /entity_advanced_settings/1
  # GET /entity_advanced_settings/1.json
  def show
    @entity_advanced_setting = EntityAdvancedSetting.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @entity_advanced_setting }
    end
  end

  # GET /entity_advanced_settings/new
  # GET /entity_advanced_settings/new.json
  def new
    @entity_advanced_setting = EntityAdvancedSetting.new
    #beyond simple html, use show code
  end

  # GET /entity_advanced_settings/1/edit
  def edit
    @entity_advanced_setting = EntityAdvancedSetting.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /entity_advanced_settings
  # POST /entity_advanced_settings.json
  def create
    @entity_advanced_setting = EntityAdvancedSetting.new(params[:entity_advanced_setting])

    #beyond simple html
    respond_to do |format|
      if @entity_advanced_setting.save
        format.html { redirect_to @entity_advanced_setting, notice: 'Entity advanced setting was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @entity_advanced_setting, status: :created, location: @entity_advanced_setting }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @entity_advanced_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entity_advanced_settings/1
  # PUT /entity_advanced_settings/1.json
  def update
    @entity_advanced_setting = EntityAdvancedSetting.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @entity_advanced_setting.update_attributes(params[:entity_advanced_setting])
        format.html { redirect_to @entity_advanced_setting, notice: 'Entity advanced setting was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @entity_advanced_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entity_advanced_settings/1
  # DELETE /entity_advanced_settings/1.json
  def destroy
    @entity_advanced_setting = EntityAdvancedSetting.find(params[:id])
    @entity_advanced_setting.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to entity_advanced_settings_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end