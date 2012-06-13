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

  describe "current_user method" do

    it "should start as nil" do
      session[:user_id].should be_nil
      controller.send(:current_user).should be_nil
    end

    it "should return nil from an invalid value" do
      session[:user_id].should be_nil
      session[:user_id] = rand(100)
      controller.send(:current_user).should be_nil
    end

    it "should return a user from a valid value" do
      session[:user_id].should be_nil
      session[:user_id] = Fabricate(:user).id
      controller.send(:current_user).is_a?(User).should be_true
    end

  end
  #describe "GET 'create'"
  #this is being tested in the request directory
end
