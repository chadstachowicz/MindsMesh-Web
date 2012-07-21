require "spec_helper"

describe "api_v1" do
  describe "routing" do
    describe "home" do
      
      it "routes to #index" do
        get("/v1/home/posts").should route_to("v1/home#posts")
      end

    end
    describe "users" do

      it "routes to #show" do
        get("/v1/users/1").should route_to("v1/users#show", :id => "1")
      end

      it "routes to #posts" do
        get("/v1/users/1/posts").should route_to("v1/users#posts", :id => "1")
      end
      
      it "routes to #batch" do
        get("/v1/users/batch").should route_to("v1/users#batch")
      end

    end
    describe "topics" do

      it "routes to #show" do
        get("/v1/topics/1").should route_to("v1/topics#show", :id => "1")
      end

      it "routes to #posts" do
        get("/v1/topics/1/posts").should route_to("v1/topics#posts", :id => "1")
      end
      
      it "routes to #batch" do
        get("/v1/topics/batch").should route_to("v1/topics#batch")
      end

    end


  end
end
