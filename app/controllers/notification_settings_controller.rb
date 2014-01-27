class NotificationSettingsController < ApplicationController
  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /notification_settings
  def index
  end

  # GET /notification_settings/1
  def show
  end

  # GET /notification_settings/new
  def new
  end

  # POST /notification_settings
  def create
    if @notification_setting.save
      redirect_to @notification_setting, notice: 'Notification setting was created.'
    else
      render action: "new"
    end
  end

  # GET /notification_settings/1/edit
  def edit
  end

  # PUT /notification_settings/1
  def update
    if @notification_setting.update_attributes(params[:notification_setting])
      redirect_to @notification_setting, notice: 'Notification setting was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /notification_settings/1
  def destroy
    @notification_setting.destroy
    redirect_to notification_settings_url
  end

end

=begin
  # GET /notification_settings
  # GET /notification_settings.json
  def index
    @notification_settings = NotificationSetting.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @notification_settings }
    end
  end

  # GET /notification_settings/1
  # GET /notification_settings/1.json
  def show
    @notification_setting = NotificationSetting.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @notification_setting }
    end
  end

  # GET /notification_settings/new
  # GET /notification_settings/new.json
  def new
    @notification_setting = NotificationSetting.new
    #beyond simple html, use show code
  end

  # GET /notification_settings/1/edit
  def edit
    @notification_setting = NotificationSetting.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /notification_settings
  # POST /notification_settings.json
  def create
    @notification_setting = NotificationSetting.new(params[:notification_setting])

    #beyond simple html
    respond_to do |format|
      if @notification_setting.save
        format.html { redirect_to @notification_setting, notice: 'Notification setting was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @notification_setting, status: :created, location: @notification_setting }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @notification_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notification_settings/1
  # PUT /notification_settings/1.json
  def update
    @notification_setting = NotificationSetting.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @notification_setting.update_attributes(params[:notification_setting])
        format.html { redirect_to @notification_setting, notice: 'Notification setting was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @notification_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_settings/1
  # DELETE /notification_settings/1.json
  def destroy
    @notification_setting = NotificationSetting.find(params[:id])
    @notification_setting.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to notification_settings_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end