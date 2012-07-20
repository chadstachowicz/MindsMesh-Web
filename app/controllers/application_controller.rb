class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  before_filter do
    logger.info "Custom: #{custom_log_hash}"
  end

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) rescue nil if session[:user_id]
  end

  def redirect_to_landing_home_page
    return redirect_to '/auth/facebook' if params['signed_request']
    return redirect_to :home_guest     unless current_user
    return redirect_to :root           if current_user
    #return redirect_to :home_moderator if current_user.moderator?
    #return redirect_to :home_manager   if current_user.manager?
    #return redirect_to :home_admin     if current_user.admin?
    #return redirect_to :home_master    if current_user.master?
    return redirect_to :home_user
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
    {'session' => session.to_hash.except("_csrf_token")}
  end

end
