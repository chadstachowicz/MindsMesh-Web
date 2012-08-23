class SessionController < ApplicationController

  def logout
    session.clear
    redirect_to_landing_home_page
  end

  def create
    login = Login.auth! request.env["omniauth.auth"]
    session[:user_id] = login.user_id

    cookies['user_id']    = login.user_id
    cookies['user_photo'] = login.user.photo_url('large')
    cookies['user_name']  = login.user.name
    cookies['user_link']  = url_for(login.user)

    return redirect_to home_entities_path if current_user.entity_users.size.zero?

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
