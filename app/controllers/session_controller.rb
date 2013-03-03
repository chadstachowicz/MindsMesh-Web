class SessionController < ApplicationController

  #TODO: cancan all controllers
  def logout
    session.clear
    redirect_to_landing_home_page
  end

  def create
    user = Login.auth! request.env["omniauth.auth"]
    session[:user_id] = user.id



    #last login at
    #this cookie will be checked and unset at home/ajax_application.js
    cookies['suggest_invites'] = true if user.last_login_at.nil? || user.last_login_at < 20.hours.ago
    user.last_login_at = Time.now
    user.save

    user.login_logs.create!(user_agent: request.user_agent)

    cookies['user_id']    = user.id
    cookies['user_photo'] = user.photo_url('large')
    cookies['user_name']  = user.name
    cookies['user_link']  = url_for(user)

    if session[:must_clear_fb_apprequests]
      session[:must_clear_fb_apprequests] = nil
      logger.info "Resque.enqueue('facebook.apprequests.clear', user_id: #{user.id})"
      Resque.enqueue('facebook.apprequests.clear', "", user.id)
    end
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
