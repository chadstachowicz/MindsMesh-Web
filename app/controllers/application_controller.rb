class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) rescue nil if session[:user_id]
  end

  def must_user
    redirect_to session_login_url, alert: 'Login Necessario' unless current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to denied_url, alert: exception.message
  end
end
