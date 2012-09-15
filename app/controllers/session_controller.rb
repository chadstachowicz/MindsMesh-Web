class SessionController < ApplicationController

  #TODO: cancan all controllers
  def logout
    session.clear
    redirect_to_landing_home_page
  end

  def create
    login = Login.auth! request.env["omniauth.auth"]
    session[:user_id] = login.user_id



    #last login at
    cookies['suggest_invites'] = true if login.user.last_login_at.nil? || login.user.last_login_at < 20.hours.ago
    login.user.last_login_at = Time.now
    login.user.save

    login.user.login_logs.create!(user_agent: request.user_agent)

    cookies['user_id']    = login.user_id
    cookies['user_photo'] = login.user.photo_url('large')
    cookies['user_name']  = login.user.name
    cookies['user_link']  = url_for(login.user)
    redirect_to_landing_home_page
  end

  def switch
    if params[:user_id] && current_user.master?
      session[:master_id] = session[:user_id]
  	  session[:user_id]   = params[:user_id]
    elsif session[:master_id]
      session[:user_id]   = session[:master_id]
      session[:master_id] = nil
  	end
  	redirect_to root_path
  end
  
end
