
# MindsMesh (c) 2013

require 'spec_helper'

describe Api::V1::SessionController do

  def valid_params
    @user = Fabricate(:user)
    {access_token: @user.access_token}
  end

  describe "me" do
    it "works" do
      Api::V1::UserPresenter.any_instance.should_not_receive(:as_me)

      get :me, valid_params
      response.status.should == 200
      response.body.should include @user.access_token
    end
  end

  describe "login" do

    before do
      Koala::Facebook::API.any_instance.stub(:get_object) do |args|
        if args=='me'
          {
            "id"=>"1307529248", "name"=>"Thiago Pinto", "first_name"=>"Thiago", "last_name"=>"Pinto",
            "link"=>"http://www.facebook.com/thiago88", "username"=>"thiago88", "birthday"=>"02/20/1988",
            "gender"=>"male", "email"=>"tapgyn@gmail.com", "timezone"=>-5,
            "locale"=>"en_US", "verified"=>true, "updated_time"=>"2012-12-16T01:25:22+0000"
          }
        else
          :stub_with_bad_arguments
        end
      end
    end

    it "without fields" do
      get :login, {}
      response.body.should include 'fb_access_token is invalid'
      response.status.should == 401
    end

    it "with fb_access_token param" do
      l = Fabricate(:login)

      get :login, {fb_access_token: l.user.fb_token}
      response.body.should include 'Thiago Pinto'
      response.status.should == 200
    end

    it "with fb_expires_at too" do
      dt = 1.day.from_now.to_i.to_s
      l = Fabricate(:login)

      get :login, {fb_access_token: l.user.fb_token, fb_expires_at: dt}
      response.body.should include 'Thiago Pinto'
      response.status.should == 200
    end

  end
end
