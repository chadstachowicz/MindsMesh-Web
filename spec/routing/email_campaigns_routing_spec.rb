require "spec_helper"

describe EmailCampaignsController do
  describe "routing" do

    it "routes to #index" do
      get("/email_campaigns").should route_to("email_campaigns#index")
    end

    it "routes to #new" do
      get("/email_campaigns/new").should route_to("email_campaigns#new")
    end

    it "routes to #show" do
      get("/email_campaigns/1").should route_to("email_campaigns#show", :id => "1")
    end

    it "routes to #edit" do
      get("/email_campaigns/1/edit").should route_to("email_campaigns#edit", :id => "1")
    end

    it "routes to #create" do
      post("/email_campaigns").should route_to("email_campaigns#create")
    end

    it "routes to #update" do
      put("/email_campaigns/1").should route_to("email_campaigns#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/email_campaigns/1").should route_to("email_campaigns#destroy", :id => "1")
    end

  end
end
