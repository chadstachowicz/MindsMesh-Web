require "spec_helper"

describe HomeController do
  describe "routing" do

    it "routes to #denied" do
      get("/home/denied").should route_to("home#denied")
    end

    it "routes to #guest" do
      get("/home/guest").should route_to("home#guest")
    end

    it "routes to #user" do
      get("/home/user").should route_to("home#user")
    end

    it "routes to #client" do
      get("/").should route_to("home#client")
    end

    it "routes to #user_create_eur" do
      post("/home/user_create_eur").should route_to("home#user_create_eur")
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
