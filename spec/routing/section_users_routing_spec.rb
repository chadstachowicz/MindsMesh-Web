require "spec_helper"

describe SectionUsersController do
  describe "routing" do

    it "routes to #index" do
      get("/section_users").should route_to("section_users#index")
    end

    it "routes to #new" do
      get("/section_users/new").should route_to("section_users#new")
    end

    it "routes to #show" do
      get("/section_users/1").should route_to("section_users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/section_users/1/edit").should route_to("section_users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/section_users").should route_to("section_users#create")
    end

    it "routes to #update" do
      put("/section_users/1").should route_to("section_users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/section_users/1").should route_to("section_users#destroy", :id => "1")
    end

  end
end
