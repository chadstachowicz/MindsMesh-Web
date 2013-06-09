class EntitiesController < ApplicationController
  respond_to :html, :json, :js
  load_and_authorize_resource

  # GET /entities
  def index
    render layout: 'datatables'
  end
    
  def lti
    require 'ims/lti'
      @entity = Entity.find(params[:entity_id])
      provider = IMS::LTI::ToolProvider.new(@entity.entity_advanced_setting.lti_consumer_key, @entity.entity_advanced_setting.lti_consumer_secret, params)
      
      if provider.valid_request?(request)
          # You need to implement the method below in your model (e.g. app/models/user.rb)
          @user = User.find_for_lti_oauth(provider, current_user, params[:entity_id])
          
          if @user.persisted?
              sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
              else
              session["devise.lti_data"] = provider
              redirect_to new_user_registration_url
          end
          
          else
          flash[:notice] = "Invalid Moodle"
      end
        
    redirect_to_landing_home_page
  end
    
  def settings
      @settings = Entity.find(params[:entity_id]).entity_advanced_setting
      if @settings.nil?
          @settings = EntityAdvancedSetting.new
      end

  end



  # GET /entities/datatable_filter
  def datatable_filter
    render json: EntitiesDatatable.new(view_context)
  end

  # GET /entities/select2_filter.js
  # params: 
  def select2_filter
    page_limit = params[:page_limit] || 10
    q = "%#{params[:q].to_s.gsub(' ', '%')}%"
    @entities = @entities.where("UPPER(name) lIKE UPPER(:q)", q: q).limit(page_limit)
    #respond_with(@entities)
  end

  # GET /entities/1
  def show
    respond_with(@entity)
  end

  # GET /entities/new
  def new
    respond_with(@entity)
  end

  # GET /entities/1/edit
  def edit
    respond_with(@entity)
  end

  # POST /entities
  def create
    if @entity.save
      flash[:notice] = "Entity successfully created."
    end
    respond_with(@entity, location: @entity)
  end

  # PUT /entities/1
  def update
    #@entity.update_attributes(params[:entity])
    if @entity.update_attributes(params[:entity])
      flash[:notice] = "Entity successfully updated."
    end
    respond_with(@entity, location: @entity)
  end

  # DELETE /entities/1
  def destroy
    @entity.destroy
    respond_with(@entity)
  end
end
