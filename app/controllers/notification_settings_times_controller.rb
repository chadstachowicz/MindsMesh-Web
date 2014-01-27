class NotificationSettingsTimesController < ApplicationController
  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /notification_settings_times
  def index
  end

  # GET /notification_settings_times/1
  def show
  end

  # GET /notification_settings_times/new
  def new
  end

  # POST /notification_settings_times
  def create
    if @notification_settings_time.save
      redirect_to @notification_settings_time, notice: 'Notification settings time was created.'
    else
      render action: "new"
    end
  end

  # GET /notification_settings_times/1/edit
  def edit
  end

  # PUT /notification_settings_times/1
  def update
    if @notification_settings_time.update_attributes(params[:notification_settings_time])
      redirect_to @notification_settings_time, notice: 'Notification settings time was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /notification_settings_times/1
  def destroy
    @notification_settings_time.destroy
    redirect_to notification_settings_times_url
  end

end

=begin
  # GET /notification_settings_times
  # GET /notification_settings_times.json
  def index
    @notification_settings_times = NotificationSettingsTime.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @notification_settings_times }
    end
  end

  # GET /notification_settings_times/1
  # GET /notification_settings_times/1.json
  def show
    @notification_settings_time = NotificationSettingsTime.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @notification_settings_time }
    end
  end

  # GET /notification_settings_times/new
  # GET /notification_settings_times/new.json
  def new
    @notification_settings_time = NotificationSettingsTime.new
    #beyond simple html, use show code
  end

  # GET /notification_settings_times/1/edit
  def edit
    @notification_settings_time = NotificationSettingsTime.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /notification_settings_times
  # POST /notification_settings_times.json
  def create
    @notification_settings_time = NotificationSettingsTime.new(params[:notification_settings_time])

    #beyond simple html
    respond_to do |format|
      if @notification_settings_time.save
        format.html { redirect_to @notification_settings_time, notice: 'Notification settings time was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @notification_settings_time, status: :created, location: @notification_settings_time }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @notification_settings_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notification_settings_times/1
  # PUT /notification_settings_times/1.json
  def update
    @notification_settings_time = NotificationSettingsTime.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @notification_settings_time.update_attributes(params[:notification_settings_time])
        format.html { redirect_to @notification_settings_time, notice: 'Notification settings time was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @notification_settings_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_settings_times/1
  # DELETE /notification_settings_times/1.json
  def destroy
    @notification_settings_time = NotificationSettingsTime.find(params[:id])
    @notification_settings_time.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to notification_settings_times_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end