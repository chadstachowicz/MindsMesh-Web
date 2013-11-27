
# MindsMesh, Inc. (c) 2012-2013

class Admin::CampaignsController < ApplicationController

  #load_and_authorize_resource

  respond_to :html, :json, :js
  
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

  def groups

    @newsletter_id  = params[:admin_campaign][:newsletter_id]
    @kind           = params[:admin_campaign][:kind]

    #return render :text => @kind
     
    if @kind == 'everybody'
        @emails_sent = Admin::Campaign.everybody(@newsletter_id)
        @email_id    = @newsletter_id
        return render :template => '/admin/campaigns/create'
    end

    @admin_campaign = Admin::Campaign.new
    @data           = Admin::Newsletter.get_group(params[:admin_campaign][:entity_id], params[:admin_campaign][:kind])  # pass the array

    #return render :text => @data
    #respond_to do |format|
    #    format.html { render :layout => !request.xhr? }
    #end
    
  end

  # POST /admin/campaigns
  def create

    #return render :text => params[:admin_campaign]
                                   
    @emails_sent = Admin::Campaign.send_mails_and_save(params[:admin_campaign])
    @email_id    = params[:admin_campaign][:newsletter_id]

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
