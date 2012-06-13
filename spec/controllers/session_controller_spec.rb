require 'spec_helper'

describe SessionController do

  describe "GET 'login'" do
    it "returns http success" do
      get 'login'
      response.should be_success
    end
  end

  describe "GET 'logout'" do
    it "clears session and redirects to login" do
      session[:user_id] = 1
      get 'logout'

      session[:user_id].should be_nil
      response.should redirect_to session_login_path
    end
  end

  #describe "GET 'create'"
  #this is being tested in the request directory
end
