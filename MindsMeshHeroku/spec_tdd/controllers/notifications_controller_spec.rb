require 'spec_helper'

describe NotificationsController do

  describe "GET 'show'" do
    it "redirects to target" do
      n = Fabricate(:notification, user: current_user_master)
      get 'show', {id: n.to_param}, valid_session
      response.should redirect_to n.target
    end
  end

end
