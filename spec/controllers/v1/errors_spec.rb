require 'spec_helper'

describe V1::UsersController do

  describe "show" do

    it "404 not found" do
      get :show, {id: -1}
      response.status.should == 404
    end
    
  end

end
