require "spec_helper"

describe RepliesController do
  describe "routing" do

    it "routes to #like" do
      put("/replies/1/like").should route_to("replies#like", :id => "1")
    end
    it "routes to #update" do
      put("/replies/1").should route_to("replies#update", :id => "1")
    end

  end
end
