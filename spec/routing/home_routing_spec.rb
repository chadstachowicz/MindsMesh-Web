require "spec_helper"

describe HomeController do
  describe "routing" do

    it "routes to #index" do
      get("/home/index").should route_to("home#index")
    end

    it "routes to #guest" do
      get("/home/guest").should route_to("home#guest")
    end

    it "routes to #user" do
      get("/home/user").should route_to("home#user")
    end

    it "routes to #create_school_request" do
      post("/home/user").should route_to("home#user_create_school_request", format: 'js')
    end

    it "routes to #student" do
      get("/home/student").should route_to("home#student")
    end

    it "routes to #moderator" do
      get("/home/moderator").should route_to("home#moderator")
    end

    it "routes to #teacher" do
      get("/home/teacher").should route_to("home#teacher")
    end

    it "routes to #admin" do
      get("/home/admin").should route_to("home#admin")
    end

    it "routes to #master" do
      get("/home/master").should route_to("home#master")
    end




    it "routes to #create_post" do
      post("/home/create_post").should route_to("home#create_post", format: 'js')
    end

    it "routes to #more_posts" do
      get("/home/more_posts").should route_to("home#more_posts", format: 'js')
    end

  end
end
