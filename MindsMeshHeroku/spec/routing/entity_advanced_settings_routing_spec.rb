require "spec_helper"

describe EntityAdvancedSettingsController do
  describe "routing" do

    it "routes to #index" do
      get("/entity_advanced_settings").should route_to("entity_advanced_settings#index")
    end

    it "routes to #new" do
      get("/entity_advanced_settings/new").should route_to("entity_advanced_settings#new")
    end

    it "routes to #show" do
      get("/entity_advanced_settings/1").should route_to("entity_advanced_settings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/entity_advanced_settings/1/edit").should route_to("entity_advanced_settings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/entity_advanced_settings").should route_to("entity_advanced_settings#create")
    end

    it "routes to #update" do
      put("/entity_advanced_settings/1").should route_to("entity_advanced_settings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/entity_advanced_settings/1").should route_to("entity_advanced_settings#destroy", :id => "1")
    end

  end
end
