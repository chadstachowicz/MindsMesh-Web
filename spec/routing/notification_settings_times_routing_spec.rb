require "spec_helper"

describe NotificationSettingsTimesController do
  describe "routing" do

    it "routes to #index" do
      get("/notification_settings_times").should route_to("notification_settings_times#index")
    end

    it "routes to #new" do
      get("/notification_settings_times/new").should route_to("notification_settings_times#new")
    end

    it "routes to #show" do
      get("/notification_settings_times/1").should route_to("notification_settings_times#show", :id => "1")
    end

    it "routes to #edit" do
      get("/notification_settings_times/1/edit").should route_to("notification_settings_times#edit", :id => "1")
    end

    it "routes to #create" do
      post("/notification_settings_times").should route_to("notification_settings_times#create")
    end

    it "routes to #update" do
      put("/notification_settings_times/1").should route_to("notification_settings_times#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/notification_settings_times/1").should route_to("notification_settings_times#destroy", :id => "1")
    end

  end
end
