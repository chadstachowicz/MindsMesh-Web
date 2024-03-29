require "spec_helper"

describe TopicsController do
  describe "routing" do

    it "routes to #index" do
      get("/topics").should route_to("topics#index")
    end
    it "routes to #filter" do
      get("/topics/filter").should route_to("topics#filter")
    end

    it "routes to #new" do
      get("/topics/new").should route_to("topics#new")
    end

    it "routes to #show" do
      get("/topics/1").should route_to("topics#show", :id => "1")
    end

    it "routes to #join" do
      put("/topics/1/join").should route_to("topics#join", :id => "1")
    end

    it "routes to #leave" do
      put("/topics/1/leave").should route_to("topics#leave", :id => "1")
    end

    it "routes to #more_posts" do
      get("/topics/1/more_posts").should route_to("topics#more_posts", :id => "1")
    end





    it "routes to #edit" do
      get("/topics/1/edit").should route_to("topics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/topics").should route_to("topics#create")
    end

    it "routes to #update" do
      put("/topics/1").should route_to("topics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/topics/1").should route_to("topics#destroy", :id => "1")
    end

  end
end
