require "spec_helper"

describe NotificationSettingsController do
  describe "routing" do

    it "routes to #index" do
      get("/notification_settings").should route_to("notification_settings#index")
    end

    it "routes to #new" do
      get("/notification_settings/new").should route_to("notification_settings#new")
    end

    it "routes to #show" do
      get("/notification_settings/1").should route_to("notification_settings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/notification_settings/1/edit").should route_to("notification_settings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/notification_settings").should route_to("notification_settings#create")
    end

    it "routes to #update" do
      put("/notification_settings/1").should route_to("notification_settings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/notification_settings/1").should route_to("notification_settings#destroy", :id => "1")
    end

  end
end
