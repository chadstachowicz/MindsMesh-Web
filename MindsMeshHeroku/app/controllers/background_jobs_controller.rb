class BackgroundJobsController < ApplicationController
  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /background_jobs
  def index
  end

  # GET /background_jobs/1
  def show
  end

  # GET /background_jobs/new
  def new
  end

  # POST /background_jobs
  def create
    if @background_job.save
      redirect_to @background_job, notice: 'Background job was created.'
    else
      render action: "new"
    end
  end

  # GET /background_jobs/1/edit
  def edit
  end

  # PUT /background_jobs/1
  def update
    if @background_job.update_attributes(params[:background_job])
      redirect_to @background_job, notice: 'Background job was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /background_jobs/1
  def destroy
    @background_job.destroy
    redirect_to background_jobs_url
  end

end

=begin
  # GET /background_jobs
  # GET /background_jobs.json
  def index
    @background_jobs = BackgroundJob.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @background_jobs }
    end
  end

  # GET /background_jobs/1
  # GET /background_jobs/1.json
  def show
    @background_job = BackgroundJob.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @background_job }
    end
  end

  # GET /background_jobs/new
  # GET /background_jobs/new.json
  def new
    @background_job = BackgroundJob.new
    #beyond simple html, use show code
  end

  # GET /background_jobs/1/edit
  def edit
    @background_job = BackgroundJob.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /background_jobs
  # POST /background_jobs.json
  def create
    @background_job = BackgroundJob.new(params[:background_job])

    #beyond simple html
    respond_to do |format|
      if @background_job.save
        format.html { redirect_to @background_job, notice: 'Background job was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @background_job, status: :created, location: @background_job }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @background_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /background_jobs/1
  # PUT /background_jobs/1.json
  def update
    @background_job = BackgroundJob.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @background_job.update_attributes(params[:background_job])
        format.html { redirect_to @background_job, notice: 'Background job was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @background_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /background_jobs/1
  # DELETE /background_jobs/1.json
  def destroy
    @background_job = BackgroundJob.find(params[:id])
    @background_job.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to background_jobs_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end