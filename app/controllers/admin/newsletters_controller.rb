
# MindsMesh, Inc. (c) 2012-2013

class Admin::NewslettersController < ApplicationController

  respond_to :html, :json, :js

  load_and_authorize_resource

  # TODO: name these comments properly with all the matching URLs to each action
  # GET /admin/newsletters
  def index
    @admin_newsletters = Admin::Newsletter.paginate(:page => params[:page], :per_page => 10).order('id DESC')
  end

  # GET /admin/newsletters/1
  def show
    @admin_newsletter = Admin::Newsletter.find(params[:id])
  end
  
  # GET /admin/newsletters/select/1
  def select
    @admin_newsletter = Admin::Newsletter.find(params[:id])
    @entities = Entity.find(:all)
    @admin_campaign = Admin::Campaign.new
  end
  
  # GET /admin/newsletters/group/1
  def groups
    # DEPEERACTED
    # return render :text => params[:admin_newsletter][:element_id]

    @newsletter_id  = params[:newsletter_id]
    @kind  = params[:kind]
    @admin_campaign = Admin::Campaign.new
    @data           = Admin::Newsletter.get_group(params[:admin_newsletter][:element_id], params[:kind])  # pass the array
    #return render :text => @data
    #respond_to do |format|
    #    format.html { render :layout => !request.xhr? }
    #end
    
  end

  # GET /admin/newsletters/test/1
  def test
    @admin_newsletter = Admin::Newsletter.find(params[:id])
  end
  
    # GET /admin/newsletters/test/1
  def historic
    @admin_newsletter = Admin::Newsletter.find(params[:id])
  end

  # GET /admin/newsletters/new
  def new
    @admin_newsletter = Admin::Newsletter.new
  end

  # POST /admin/newsletters
  def create
    @admin_newsletter = Admin::Newsletter.new(params[:admin_newsletter])
    @admin_newsletter.status = false

    if @admin_newsletter.save
      redirect_to @admin_newsletter, notice: 'Newsletter was created.'
    else
      render action: "new"
    end
  end

  # GET /admin/newsletters/1/edit
  def edit
    @admin_newsletter = Admin::Newsletter.find(params[:id])
  end

  # PUT /admin/newsletters/1
  def update

    @admin_newsletter = Admin::Newsletter.find(params[:id])

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
