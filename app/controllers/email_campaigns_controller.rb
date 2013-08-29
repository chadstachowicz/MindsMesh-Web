class EmailCampaignsController < ApplicationController
  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /email_campaigns
  def index
  end

  # GET /email_campaigns/1
  def show
  end

  # GET /email_campaigns/new
  def new
  end

  # POST /email_campaigns
  def create
    if @email_campaign.save
      redirect_to @email_campaign, notice: 'Email campaign was created.'
    else
      render action: "new"
    end
  end

  # GET /email_campaigns/1/edit
  def edit
  end

  # PUT /email_campaigns/1
  def update
    if @email_campaign.update_attributes(params[:email_campaign])
      redirect_to @email_campaign, notice: 'Email campaign was updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /email_campaigns/1
  def destroy
    @email_campaign.destroy
    redirect_to email_campaigns_url
  end

end

=begin
  # GET /email_campaigns
  # GET /email_campaigns.json
  def index
    @email_campaigns = EmailCampaign.all

    #beyond simple html
    respond_to do |format|
      format.html {  } # index.html.erb
      format.js   {  } # index.js.erb
      format.json { render json: @email_campaigns }
    end
  end

  # GET /email_campaigns/1
  # GET /email_campaigns/1.json
  def show
    @email_campaign = EmailCampaign.find(params[:id])

    #beyond simple html
    respond_to do |format|
      format.html {  } # show.html.erb
      format.js   {  } # show.js.erb
      format.json { render json: @email_campaign }
    end
  end

  # GET /email_campaigns/new
  # GET /email_campaigns/new.json
  def new
    @email_campaign = EmailCampaign.new
    #beyond simple html, use show code
  end

  # GET /email_campaigns/1/edit
  def edit
    @email_campaign = EmailCampaign.find(params[:id])
    #beyond simple html, use show code
  end

  # POST /email_campaigns
  # POST /email_campaigns.json
  def create
    @email_campaign = EmailCampaign.new(params[:email_campaign])

    #beyond simple html
    respond_to do |format|
      if @email_campaign.save
        format.html { redirect_to @email_campaign, notice: 'Email campaign was created.' }
        format.js   {  } # create.js.erb
        format.json { render json: @email_campaign, status: :created, location: @email_campaign }
      else
        format.html { render action: "new" }
        format.js   {  } # create.js.erb
        #format.js   { render 'create_fail' } # create_fail.js.erb
        format.json { render json: @email_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /email_campaigns/1
  # PUT /email_campaigns/1.json
  def update
    @email_campaign = EmailCampaign.find(params[:id])

    #beyond simple html
    respond_to do |format|
      if @email_campaign.update_attributes(params[:email_campaign])
        format.html { redirect_to @email_campaign, notice: 'Email campaign was updated.' }
        format.js   {  } # update.js.erb
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js   {  } # update.js.erb
        #format.js   { render 'update_fail' } # update_fail.js.erb
        format.json { render json: @email_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_campaigns/1
  # DELETE /email_campaigns/1.json
  def destroy
    @email_campaign = EmailCampaign.find(params[:id])
    @email_campaign.destroy

    #beyond simple html
    respond_to do |format|
      format.html { redirect_to email_campaigns_url }
      format.js   {  } # destroy.js.erb
      format.json { head :no_content }
    end
  end
=end