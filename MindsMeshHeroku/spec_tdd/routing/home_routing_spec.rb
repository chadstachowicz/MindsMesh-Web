require "spec_helper"

describe HomeController do
  describe "routing" do

    it "routes to #denied" do
      get("/home/denied").should route_to("home#denied")
    end

    it "routes to #login" do
      get("/home/login").should route_to("home#login")
    end

    it "routes to #entities" do
      get("/home/entities").should route_to("home#entities")
    end

    it "routes to #index" do
      get("/").should route_to("home#index")
    end

    it "routes to #create_entity_request" do
      post("/home/entities").should route_to("home#create_entity_request")
    end
    it "routes to #change_access_token" do
      post("/home/change_access_token").should route_to("home#change_access_token")
    end
=begin
    it "routes to #moderator" do
      get("/home/moderator").should route_to("home#moderator")
    end

    it "routes to #manager" do
      get("/home/manager").should route_to("home#manager")
    end

    it "routes to #admin" do
      get("/home/admin").should route_to("home#admin")
    end

    it "routes to #master" do
      get("/home/master").should route_to("home#master")
    end
=end



    it "routes to #create_post" do
      post("/home/create_post").should route_to("home#create_post")
    end

    it "routes to #more_posts" do
      get("/home/more_posts").should route_to("home#more_posts")
    end

  end
end
