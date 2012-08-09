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

    it "without fields" do
      Login.should_not_receive(:with_access_token)
      Api::V1::UserPresenter.should_not_receive(:new)

      get :login, {}
      response.status.should == 401
    end

    it "with fb_access_token param" do
      Login.stub(with_access_token!: Fabricate(:login))
      Login.should_receive(:with_access_token!).with('123', nil)
      Api::V1::UserPresenter.any_instance.should_receive(:as_me)

      get :login, {fb_access_token: '123'}
      response.status.should == 200
    end

    it "with fb_expires_at too" do
      Login.stub(with_access_token!: Fabricate(:login))
      dt = 1.day.from_now.to_i
      Login.should_receive(:with_access_token!).with('123', dt.to_s)
      Api::V1::UserPresenter.any_instance.should_receive(:as_me)

      get :login, {fb_access_token: '123', fb_expires_at: dt}
      response.status.should == 200
    end

  end
end
