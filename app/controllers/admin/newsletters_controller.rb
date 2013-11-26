
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
    @entities = Entity.find(:all)
    @admin_campaign = Admin::Campaign.new
  end
  
  # GET /admin/newsletters/group/1
  def groups
    # DEPRECATED
    # return render :text => params[:admin_newsletter][:element_id]

    @newsletter_id  = params[:newsletter_id]
    @kind           = params[:kind]
    @admin_campaign = Admin::Campaign.new
    @data           = Admin::Newsletter.get_group(params[:admin_newsletter][:element_id], params[:kind])  # pass the array

  end

  # GET /admin/newsletters/test/1
  def test
     nl   = Admin::Newsletter.find(params[:id])
     user = User.find(current_user.id)
     MyMail.send_newsletter(user,nl).deliver
     redirect_to admin_newsletters_path, notice: "The email: \"#{nl.title}\" has been sent to you."
  end
  
  # GET /admin/newsletters/statics/1
  def statics
    @admin_newsletter = Admin::Newsletter.find(params[:id])

    @data = Admin::Newsletter.single(params[:id])
    # return render :text => @data

  end
  
  # GET /admin/newsletters/generalstats
  def generalstats
    now   = Date.today
    # return render :text => params.inspect
    from = params.has_key?(:from) ? params[:from] : (now - 30);
    to   = params.has_key?(:to)   ? params[:to]   : Date.today;
    startdate = from
    enddate   = to 
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
