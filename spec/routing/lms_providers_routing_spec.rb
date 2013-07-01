require "spec_helper"

describe LmsProvidersController do
  describe "routing" do

    it "routes to #index" do
      get("/lms_providers").should route_to("lms_providers#index")
    end

    it "routes to #new" do
      get("/lms_providers/new").should route_to("lms_providers#new")
    end

    it "routes to #show" do
      get("/lms_providers/1").should route_to("lms_providers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/lms_providers/1/edit").should route_to("lms_providers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/lms_providers").should route_to("lms_providers#create")
    end

    it "routes to #update" do
      put("/lms_providers/1").should route_to("lms_providers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/lms_providers/1").should route_to("lms_providers#destroy", :id => "1")
    end

  end
end
