require 'spec_helper'

describe NotifiesController do

  before do
    @notify = Fabricate(:notify_post)
  end
  
  describe "GET index" do
    it "assigns all notifies as @notifies" do
      get :index, {}, valid_session
      assigns(:notifies).should eq([@notify])
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested notify" do
      expect {
        delete :destroy, {:id => @notify.to_param}, valid_session
      }.to change(Notify, :count).by(-1)
    end

    it "redirects to the notifies list" do
      delete :destroy, {:id => @notify.to_param}, valid_session
      response.should redirect_to(notifies_url)
    end
  end

end
