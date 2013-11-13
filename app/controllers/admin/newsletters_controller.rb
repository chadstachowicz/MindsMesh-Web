class Admin::NewslettersController < ApplicationController
  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /admin/newsletters
  def index
  end

  # GET /admin/newsletters/1
  def show
  end

  # GET /admin/newsletters/new
  def new
  end

  # POST /admin/newsletters
  def create
    if @admin_newsletter.save
      redirect_to @admin_newsletter, notice: 'Newsletter was created.'
    else
      render action: "new"
    end
  end

  # GET /admin/newsletters/1/edit
  def edit
  end

  # PUT /admin/newsletters/1
  def update
    if @admin_newsletter.update_attributes(params[:admin_newsletter])
      redirect_to @admin_newsletter, notice: 'Newsletter was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /admin/newsletters/1
  def destroy
    @admin_newsletter.destroy
    redirect_to admin_newsletters_url
  end

end

=begin
  # GET /admin/newsletters
  # GET /admin/newsletters.json
  def index
    @admin_newsletters = Admin::Newsletter.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @admin_newsletters }
    end
  end

  # GET /admin/newsletters/1
  # GET /admin/newsletters/1.json
  def show
    @admin_newsletter = Admin::Newsletter.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @admin_newsletter }
    end
  end

  # GET /admin/newsletters/new
  # GET /admin/newsletters/new.json
  def new
    @admin_newsletter = Admin::Newsletter.new
    #beyond simple html, use show code
  end

  # GET /admin/newsletters/1/edit
  def edit
    @admin_newsletter = Admin::Newsletter.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /admin/newsletters
  # POST /admin/newsletters.json
  def create
    @admin_newsletter = Admin::Newsletter.new(params[:admin_newsletter])

    #beyond simple html
    respond_to do |format|
      if @admin_newsletter.save
        format.html { redirect_to @admin_newsletter, notice: 'Newsletter was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @admin_newsletter, status: :created, location: @admin_newsletter }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @admin_newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/newsletters/1
  # PUT /admin/newsletters/1.json
  def update
    @admin_newsletter = Admin::Newsletter.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @admin_newsletter.update_attributes(params[:admin_newsletter])
        format.html { redirect_to @admin_newsletter, notice: 'Newsletter was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @admin_newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/newsletters/1
  # DELETE /admin/newsletters/1.json
  def destroy
    @admin_newsletter = Admin::Newsletter.find(params[:id])
    @admin_newsletter.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to admin_newsletters_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end