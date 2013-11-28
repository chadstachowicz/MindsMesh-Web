
# MindsMesh, Inc. (c) 2012-2013

require 'date'

class Admin::NewslettersController < ApplicationController

  respond_to :html, :json, :js

  load_and_authorize_resource
  
  # TODO: name these comments properly with all the matching URLs to each action
  # GET /admin/newsletters
  def index
    @admin_newsletters = Admin::Newsletter.paginate(:page => params[:page], :per_page => 12).order('id DESC')
  end

  # GET /admin/newsletters/1
  def show
    @admin_newsletter = Admin::Newsletter.find(params[:id])
  end
  
  # GET /admin/newsletters/select/1
  def select
    @admin_newsletter = Admin::Newsletter.find(params[:id])
    @entities         = Entity.find(:all)
    @admin_campaign   = Admin::Campaign.new
  end
  
  # GET /admin/newsletters/test/1
  def test
    @admin_newsletter   = Admin::Newsletter.find(params[:id])
    #return render :text => @admin_newsletter.inspect
    if request.xhr?
        #format.html { render :layout => false } 
        respond_with(@admin_newsletter, :layout => !request.xhr? )
    else
        # respond to normal request
        email = params.has_key?(:email) ? params[:email] : current_user.email;
        MyMail.send_newsletter_test(email,@admin_newsletter).deliver
        title = @admin_newsletter.title
        #return render :text => @admin_newsletter.inspect
        redirect_to admin_newsletters_path, notice: "The email: \"#{title}\" has been sent to #{email}."
    end
  end
  
  # GET /admin/newsletters/statics/1
  def statics
    @admin_newsletter = Admin::Newsletter.find(params[:id])

    @data = Admin::Newsletter.single(params[:id])
    #return render :text => @data.class
  end
  
  # GET /admin/newsletters/generalstats
  def generalstats

    if  params.has_key?(:daterange)
        range = params[:daterange]
        from  = range[0..9]
        to    = range[13..23]
    else
        from        = (Date.today - 30)
        to          = Date.today
    end
  
    #return render :text => "From  #{from}  to :  #{to}"
    
    @data = Admin::Newsletter.general(from, to)
    #return render text:@data
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

  private 
end
