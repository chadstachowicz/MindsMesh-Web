class NotifiesController < ApplicationController
  load_and_authorize_resource
  
  # GET /notifies
  def index
  end

  # DELETE /notifies/1
  def destroy
    @notify.destroy
    redirect_to notifies_url
  end

end

=begin
  # GET /notifies
  # GET /notifies.json
  def index
    @notifies = Notify.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @notifies }
    end
  end

  # GET /notifies/1
  # GET /notifies/1.json
  def show
    @notify = Notify.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @notify }
    end
  end

  # GET /notifies/new
  # GET /notifies/new.json
  def new
    @notify = Notify.new
    #beyond simple html, use show code
  end

  # GET /notifies/1/edit
  def edit
    @notify = Notify.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /notifies
  # POST /notifies.json
  def create
    @notify = Notify.new(params[:notify])

    #beyond simple html
    respond_to do |format|
      if @notify.save
        format.html { redirect_to @notify, notice: 'Notify was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @notify, status: :created, location: @notify }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @notify.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notifies/1
  # PUT /notifies/1.json
  def update
    @notify = Notify.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @notify.update_attributes(params[:notify])
        format.html { redirect_to @notify, notice: 'Notify was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @notify.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifies/1
  # DELETE /notifies/1.json
  def destroy
    @notify = Notify.find(params[:id])
    @notify.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to notifies_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end