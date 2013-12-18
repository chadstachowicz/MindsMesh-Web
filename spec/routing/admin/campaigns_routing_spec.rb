require "spec_helper"

describe Admin::CampaignsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/campaigns").should route_to("admin/campaigns#index")
    end

    it "routes to #new" do
      get("/admin/campaigns/new").should route_to("admin/campaigns#new")
    end

    it "routes to #show" do
      get("/admin/campaigns/1").should route_to("admin/campaigns#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/campaigns/1/edit").should route_to("admin/campaigns#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/campaigns").should route_to("admin/campaigns#create")
    end

    it "routes to #update" do
      put("/admin/campaigns/1").should route_to("admin/campaigns#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/campaigns/1").should route_to("admin/campaigns#destroy", :id => "1")
    end

  end
end
