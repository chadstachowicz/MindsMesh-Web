require "spec_helper"

describe NotifiesController do
  describe "routing" do

    it "routes to #index" do
      get("/notifies").should route_to("notifies#index")
    end

    it "routes to #destroy" do
      delete("/notifies/1").should route_to("notifies#destroy", :id => "1")
    end

  end
end
