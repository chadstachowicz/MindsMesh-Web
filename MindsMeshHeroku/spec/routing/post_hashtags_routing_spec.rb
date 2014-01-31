require "spec_helper"

describe PostHashtagsController do
  describe "routing" do

    it "routes to #index" do
      get("/post_hashtags").should route_to("post_hashtags#index")
    end

    it "routes to #new" do
      get("/post_hashtags/new").should route_to("post_hashtags#new")
    end

    it "routes to #show" do
      get("/post_hashtags/1").should route_to("post_hashtags#show", :id => "1")
    end

    it "routes to #edit" do
      get("/post_hashtags/1/edit").should route_to("post_hashtags#edit", :id => "1")
    end

    it "routes to #create" do
      post("/post_hashtags").should route_to("post_hashtags#create")
    end

    it "routes to #update" do
      put("/post_hashtags/1").should route_to("post_hashtags#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/post_hashtags/1").should route_to("post_hashtags#destroy", :id => "1")
    end

  end
end
