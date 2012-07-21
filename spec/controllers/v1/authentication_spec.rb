require 'spec_helper'

describe V1::HomeController do

  describe "protected" do
    describe "authenticate" do

      it "without an access_token" do
        get :posts, {}
        response.status.should == 401
        assigns(:current_user).should eq(nil)
      end
      it "with an invalid access_token" do
        get :posts, {access_token: -1}
        response.status.should == 403
        assigns(:current_user).should eq(nil)
      end
      it "with a valid access_token" do
        user = Fabricate(:user)
        get :posts, {access_token: user.id}
        response.status.should == 200
        assigns(:current_user).should eq(user)
      end

    end
  end

end
