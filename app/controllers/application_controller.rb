class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) rescue nil if session[:user_id]
  end

  def redirect_to_landing_home_page
    return redirect_to :home_guest     unless current_user
    return redirect_to :home_user      if current_user.user?
    return redirect_to :home_student   if current_user.student?
    return redirect_to :home_moderator if current_user.moderator?
    return redirect_to :home_teacher   if current_user.teacher?
    return redirect_to :home_admin     if current_user.admin?
    return redirect_to :home_master    if current_user.master?
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

end
