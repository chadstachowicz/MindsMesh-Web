
# MindsMesh, Inc. (c) 2012-2013

class Admin::CampaignsController < ApplicationController

  load_and_authorize_resource

  respond_to :html, :json, :js
  
  self.layout "admin"

  # TODO: name these comments properly with all the matching URLs to each action
  # GET /admin/campaigns
  def index
    @admin_campaigns = Admin::Campaign.all
  end

  # GET /admin/campaigns/1
  def show
     @admin_campaign = Admin::Campaign.find(params[:id])
  end

  # GET /admin/campaigns/new
  def new
    @admin_campaign = Admin::Campaign.new
  end

  # POST /admin/campaigns
  def create
    @admin_campaign = Admin::Campaign.new(params[:admin_campaign])

    @admin_campaign.historic = false 

    if @admin_campaign.save
      redirect_to :controller =>'newsletter', :action=>'historic', notice: 'Campaign was created.'
    else
      render action: "new"
    end
  end

  # GET /admin/campaigns/1/edit
  def edit
  end

  # PUT /admin/campaigns/1
  def update
    if @admin_campaign.update_attributes(params[:admin_campaign])
      redirect_to @admin_campaign, notice: 'Campaign was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /admin/campaigns/1
  def destroy
    @admin_campaign.destroy
    redirect_to admin_campaigns_url
  end

end

=begin
  # GET /admin/campaigns
  # GET /admin/campaigns.json
  def index
    @admin_campaigns = Admin::Campaign.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @admin_campaigns }
    end
  end

  # GET /admin/campaigns/1
  # GET /admin/campaigns/1.json
  def show
    @admin_campaign = Admin::Campaign.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @admin_campaign }
    end
  end

  # GET /admin/campaigns/new
  # GET /admin/campaigns/new.json
  def new
    @admin_campaign = Admin::Campaign.new
    #beyond simple html, use show code
  end

  # GET /admin/campaigns/1/edit
  def edit
    @admin_campaign = Admin::Campaign.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /admin/campaigns
  # POST /admin/campaigns.json
  def create
    @admin_campaign = Admin::Campaign.new(params[:admin_campaign])

    #beyond simple html
    respond_to do |format|
      if @admin_campaign.save
        format.html { redirect_to @admin_campaign, notice: 'Campaign was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @admin_campaign, status: :created, location: @admin_campaign }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @admin_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/campaigns/1
  # PUT /admin/campaigns/1.json
  def update
    @admin_campaign = Admin::Campaign.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @admin_campaign.update_attributes(params[:admin_campaign])
        format.html { redirect_to @admin_campaign, notice: 'Campaign was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @admin_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/campaigns/1
  # DELETE /admin/campaigns/1.json
  def destroy
    @admin_campaign = Admin::Campaign.find(params[:id])
    @admin_campaign.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to admin_campaigns_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end