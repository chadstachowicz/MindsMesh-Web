require 'spec_helper'

describe V1::SessionController do
  describe "me" do
    it "works" do
      user = Fabricate(:user)
      V1::UserPresenter.any_instance.should_not_receive(:as_me)

      get :me, {access_token: user.id}
      response.status.should == 200
    end
  end

  describe "login" do

    it "without fields" do
      Login.should_not_receive(:with_access_token)
      V1::UserPresenter.should_not_receive(:new)

      get :login, {}
      response.status.should == 401
    end

    it "with fb_access_token param" do
      Login.stub(with_access_token!: Fabricate(:login))
      Login.should_receive(:with_access_token!).with('123', nil)
      V1::UserPresenter.any_instance.should_receive(:as_me)

      get :login, {fb_access_token: '123'}
      response.status.should == 200
    end

    it "with fb_expires_at too" do
      Login.stub(with_access_token!: Fabricate(:login))
      dt = 1.day.from_now.to_i
      Login.should_receive(:with_access_token!).with('123', dt.to_s)
      V1::UserPresenter.any_instance.should_receive(:as_me)

      get :login, {fb_access_token: '123', fb_expires_at: dt}
      response.status.should == 200
    end

  end
end
