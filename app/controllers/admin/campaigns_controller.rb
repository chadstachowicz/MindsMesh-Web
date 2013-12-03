
# MindsMesh, Inc. (c) 2012-2013

class Admin::CampaignsController < ApplicationController

  #load_and_authorize_resource

  respond_to :html, :json, :js
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /admin/campaigns
  def index
    @admin_campaigns = Admin::Campaign.paginate(:page => params[:page], :per_page => 25).order('id DESC')
  end

  # GET /admin/campaigns/1
  def show
     @admin_campaign = Admin::Campaign.find(params[:id])
  end

  # GET /admin/campaigns/new
  def new
    @admin_campaign = Admin::Campaign.new
  end

  def groups

    #return render :text => params[:admin_campaign].inspect
     
    if params[:admin_campaign][:kind] == 'everybody' 
        @data = Admin::Campaign.everybody(params[:admin_campaign])
        # return render :text => @data
        return redirect_to admin_campaigns_path , notice: 'Campaign was created.'
    end
    @scheduled      = params[:admin_campaign][:scheduled]
    @futuretime     = params[:admin_campaign][:futuretime]
    @newsletter_id  = params[:admin_campaign][:newsletter_id]
    @kind           = params[:admin_campaign][:kind]
    @admin_campaign = Admin::Campaign.new
    @data           = Admin::Newsletter.get_group(params[:admin_campaign][:entity_id], params[:admin_campaign][:kind])  # pass the array

    # return render :text => @data

  end

  # POST /admin/campaigns
  def create
    #return render :text => params[:admin_campaign]
    @data = Admin::Campaign.create_campaign(params[:admin_campaign])
    redirect_to admin_campaigns_path , notice: 'Campaign was created.'
  end

 # POST /admin/campaigns/send
  def sendcamp
    data = Admin::Campaign.send_mails_and_save(params[:id])
    redirect_to admin_campaigns_path , notice: 'Campaign was delivered.'
  end

  # GET /admin/campaigns/1/edit
  def edit
    @admin_campaign = Admin::Campaign.find(params[:id]) 
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
    @admin_campaign = Admin::Campaign.find(params[:id])
    @admin_campaign.destroy
    redirect_to admin_campaigns_url
  end

  # DELETE /admin/campaigns/1.json
  def destroyii
    @admin_campaign = Admin::Campaign.find(params[:id])
    @admin_campaign.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to admin_campaigns_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
end
