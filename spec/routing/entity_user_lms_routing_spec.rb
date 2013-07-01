require "spec_helper"

describe EntityUserLmsController do
  describe "routing" do

    it "routes to #index" do
      get("/entity_user_lms").should route_to("entity_user_lms#index")
    end

    it "routes to #new" do
      get("/entity_user_lms/new").should route_to("entity_user_lms#new")
    end

    it "routes to #show" do
      get("/entity_user_lms/1").should route_to("entity_user_lms#show", :id => "1")
    end

    it "routes to #edit" do
      get("/entity_user_lms/1/edit").should route_to("entity_user_lms#edit", :id => "1")
    end

    it "routes to #create" do
      post("/entity_user_lms").should route_to("entity_user_lms#create")
    end

    it "routes to #update" do
      put("/entity_user_lms/1").should route_to("entity_user_lms#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/entity_user_lms/1").should route_to("entity_user_lms#destroy", :id => "1")
    end

  end
end
