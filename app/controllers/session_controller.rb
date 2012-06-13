class SessionController < ApplicationController

  def login
    render text: "<a href='/auth/facebook'>login with facebook</a>".html_safe
  end

  def logout
    session.clear
    redirect_to session_login_path, notice: "Successfully logged out"
  end

  def create
    login = Login.auth! request.env["omniauth.auth"]
    session[:user_id] = login.user_id
    redirect_to root_path, notice: "Successful Login"
  end
end
