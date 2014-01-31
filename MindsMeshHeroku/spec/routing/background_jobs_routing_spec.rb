require "spec_helper"

describe BackgroundJobsController do
  describe "routing" do

    it "routes to #index" do
      get("/background_jobs").should route_to("background_jobs#index")
    end

    it "routes to #new" do
      get("/background_jobs/new").should route_to("background_jobs#new")
    end

    it "routes to #show" do
      get("/background_jobs/1").should route_to("background_jobs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/background_jobs/1/edit").should route_to("background_jobs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/background_jobs").should route_to("background_jobs#create")
    end

    it "routes to #update" do
      put("/background_jobs/1").should route_to("background_jobs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/background_jobs/1").should route_to("background_jobs#destroy", :id => "1")
    end

  end
end
