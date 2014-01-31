require "spec_helper"

describe HashtagsController do
  describe "routing" do

    it "routes to #index" do
      get("/hashtags").should route_to("hashtags#index")
    end

    it "routes to #new" do
      get("/hashtags/new").should route_to("hashtags#new")
    end

    it "routes to #show" do
      get("/hashtags/1").should route_to("hashtags#show", :id => "1")
    end

    it "routes to #edit" do
      get("/hashtags/1/edit").should route_to("hashtags#edit", :id => "1")
    end

    it "routes to #create" do
      post("/hashtags").should route_to("hashtags#create")
    end

    it "routes to #update" do
      put("/hashtags/1").should route_to("hashtags#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/hashtags/1").should route_to("hashtags#destroy", :id => "1")
    end

  end
end
