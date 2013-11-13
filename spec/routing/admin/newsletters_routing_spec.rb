require "spec_helper"

describe Admin::NewslettersController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/newsletters").should route_to("admin/newsletters#index")
    end

    it "routes to #new" do
      get("/admin/newsletters/new").should route_to("admin/newsletters#new")
    end

    it "routes to #show" do
      get("/admin/newsletters/1").should route_to("admin/newsletters#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/newsletters/1/edit").should route_to("admin/newsletters#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/newsletters").should route_to("admin/newsletters#create")
    end

    it "routes to #update" do
      put("/admin/newsletters/1").should route_to("admin/newsletters#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/newsletters/1").should route_to("admin/newsletters#destroy", :id => "1")
    end

  end
end
