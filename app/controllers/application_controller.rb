class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  before_filter do
    logger.info "Custom: #{custom_log_hash}"
    if Rails.env.test? #capybara
      ident = session[:session_id].object_id
      prms  = params.except(:controller, :action)
      ss    = session.except(:flash, :session_id)
      puts "\n#{ident}. #{request.method} #{controller_name}##{action_name}: #{prms}, #{ss}"
    end
  end

  helper_method :current_user, :me, :my_ca

  alias :me :current_user

  def my_ca
    "#{controller_name}##{action_name}"
  end

  def redirect_to_landing_home_page
    return redirect_to '/auth/facebook' if params['signed_request']
    return redirect_to :home_login      unless current_user
    return redirect_to :home_entities   if current_user.entity_users.size.zero?
      #   return redirect_to :home_topics     if current_user.topics.to_a.empty?
    
    return redirect_to :root unless controller_name=='home'&&action_name=='index'
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to denied_url, alert: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound,     with: :render_404
  #rescue_from ActionController::RoutingError,   with: :render_404
  #rescue_from ActionController::UnknownAction,  with: :render_404

  def render_404
    respond_to do |type| 
      type.html { render "errors/404", layout: 'application', status: 404 } 
      type.js   { render nothing: true, status: 404 } 
      type.all  { render nothing: true, status: 404 } 
    end
  end

  private

  def custom_log_hash
    {
      'session' => session.to_hash.except("_csrf_token", 'flash')
    }
  end

  

end
