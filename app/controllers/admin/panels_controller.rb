# MindsMesh, Inc. (c) 2012-2013

class Admin::PanelsController < ApplicationController

  respond_to :html, :json, :js

  load_and_authorize_resource(:class => false)

  # TODO: name these comments properly with all the matching URLs to each action
  # GET /admin/newsletters
  def index
    # @admin_newsletters = Admin::Newsletter.paginate(:page => params[:page], :per_page => 10).order('id DESC')
  end

  # GET /stats
  def posts
    @posts = Post.statics()
  end 

  def statics

  end 
  
  def recent

  end 

end