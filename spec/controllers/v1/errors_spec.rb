require 'spec_helper'

describe V1::UsersController do

  def valid_params
    {access_token: Fabricate(:user).access_token}
  end

  describe "show" do

    it "404 not found" do
      get :show, valid_params.merge({id: -1})
      response.status.should == 404
    end
    
  end

end
