require "spec_helper"

describe PostsController do
  describe "routing" do

    it "routes to #index" do
      get("/posts").should route_to("posts#index")
    end

    it "routes to #show" do
      get("/posts/1").should route_to("posts#show", :id => "1")
    end

    it "routes to #update" do
      put("/posts/1").should route_to("posts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/posts/1").should route_to("posts#destroy", :id => "1")
    end

    it "routes to #create_reply" do
      post("/posts/1/replies").should route_to("posts#create_reply", :id => "1")
    end
    
    it "routes to #like" do
      put("/posts/1/like").should route_to("posts#like", :id => "1")
    end

  end
end
