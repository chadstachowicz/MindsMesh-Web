require "spec_helper"

describe SessionController do
  describe "routing" do

    it "routes to #create" do
      get("/auth/1/callback").should route_to("session#create", provider: '1')
    end

    it "routes to #logout" do
      get("/session/logout").should route_to("session#logout")
    end
    it "routes to #switch" do
      put("/session/switch").should route_to("session#switch")
    end

  end
end
