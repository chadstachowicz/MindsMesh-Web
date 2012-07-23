require "spec_helper"

describe "api_v1" do
  describe "routing" do
    describe "home" do
      
      it "routes to #posts" do
        get("/v1/home/posts").should route_to("v1/home#posts")
      end
      
      it "routes to #posts_with_parents" do
        get("/v1/home/posts/with_parents").should route_to("v1/home#posts_with_parents")
      end

      it "routes to #entities" do
        get("/v1/home/entities").should route_to("v1/home#entities")
      end
      
      it "routes to #entities_with_children" do
        get("/v1/home/entities/with_children").should route_to("v1/home#entities_with_children")
      end

    end
    describe "session" do

      it "routes to #login" do
        post("/v1/session/login").should route_to("v1/session#login")
      end

      it "routes to #me" do
        get("/v1/session/me").should route_to("v1/session#me")
      end

    end
    describe "posts" do

      it "routes to #show" do
        get("/v1/posts/1").should route_to("v1/posts#show", :id => "1")
      end

      it "routes to #with_children" do
        get("/v1/posts/1/with_children").should route_to("v1/posts#with_children", :id => "1")
      end

    end
    describe "users" do

      it "routes to #show" do
        get("/v1/users/1").should route_to("v1/users#show", :id => "1")
      end

      it "routes to #with_children" do
        get("/v1/users/1/with_children").should route_to("v1/users#with_children", :id => "1")
      end

      it "routes to #posts" do
        get("/v1/users/1/posts").should route_to("v1/users#posts", :id => "1")
      end
      
      #it "routes to #batch" do
      #  get("/v1/users/batch").should route_to("v1/users#batch")
      #end

    end
    describe "topics" do

      it "routes to #show" do
        get("/v1/topics/1").should route_to("v1/topics#show", :id => "1")
      end

      it "routes to #posts" do
        get("/v1/topics/1/posts").should route_to("v1/topics#posts", :id => "1")
      end
      
      #it "routes to #batch" do
      #  get("/v1/topics/batch").should route_to("v1/topics#batch")
      #end

    end


  end
end
