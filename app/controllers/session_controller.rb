class SessionController < ApplicationController

  def logout
    session.clear
    redirect_to_landing_home_page
  end

  def create
    login = Login.auth! request.env["omniauth.auth"]
    session[:user_id] = login.user_id
    redirect_to_landing_home_page
  end
end
