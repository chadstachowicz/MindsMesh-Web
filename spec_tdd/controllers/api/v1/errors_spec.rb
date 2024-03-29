require 'spec_helper'

describe Api::V1::UsersController do

  def valid_params
    {access_token: Fabricate(:user).access_token}
  end

  describe "show" do

    it "406 not found and other exceptions" do
      get :show, valid_params.merge({id: -1})
      response.status.should == 406
      response.body.should include "ActiveRecord::RecordNotFound"
    end
    
  end

end
