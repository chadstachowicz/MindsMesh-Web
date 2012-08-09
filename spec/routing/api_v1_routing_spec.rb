require "spec_helper"

describe "api_v1" do
  describe "routing" do
    describe "home" do
      
      it "routes to #posts" do
        get("/api/v1/home/posts").should route_to("api/v1/home#posts")
      end
      
      it "routes to #posts_with_parents" do
        get("/api/v1/home/posts/with_parents").should route_to("api/v1/home#posts_with_parents")
      end

      it "routes to #entities" do
        get("/api/v1/home/entities").should route_to("api/v1/home#entities")
      end
      
      it "routes to #entities_with_children" do
        get("/api/v1/home/entities/with_children").should route_to("api/v1/home#entities_with_children")
      end
      
      it "routes to #topics" do
        get("/api/v1/home/topics").should route_to("api/v1/home#topics")
      end
      
      it "routes to #search_topics" do
        post("/api/v1/home/search_topics").should route_to("api/v1/home#search_topics")
      end

    end
    describe "session" do

      it "routes to #login" do
        post("/api/v1/session/login").should route_to("api/v1/session#login")
      end

      it "routes to #me" do
        get("/api/v1/session/me").should route_to("api/v1/session#me")
      end

    end
    describe "posts" do

      it "routes to #show" do
        get("/api/v1/posts/1").should route_to("api/v1/posts#show", :id => "1")
      end

      it "routes to #with_children" do
        get("/api/v1/posts/1/with_children").should route_to("api/v1/posts#with_children", :id => "1")
      end

      it "routes to #likes" do
        get("/api/v1/posts/1/likes").should route_to("api/v1/posts#likes", :id => "1")
      end
      
      it "routes to #likes_with_parents" do
        get("/api/v1/posts/1/likes/with_parents").should route_to("api/v1/posts#likes_with_parents", :id => "1")
      end

      #it "routes to #replies" do
      #  get("/api/v1/posts/1/replies").should route_to("api/v1/posts#replies", :id => "1")
      #end


      it "routes to #create" do
        post("/api/v1/posts").should route_to("api/v1/posts#create")
      end

      it "routes to #like" do
        post("/api/v1/posts/1/like").should route_to("api/v1/posts#like", :id => "1")
      end

      it "routes to #unlike" do
        post("/api/v1/posts/1/unlike").should route_to("api/v1/posts#unlike", :id => "1")
      end

      it "routes to #create_reply" do
        post("/api/v1/posts/1/replies").should route_to("api/v1/posts#create_reply", :id => "1")
      end

    end
    describe "replies" do

      it "routes to #show" do
        get("/api/v1/replies/1").should route_to("api/v1/replies#show", :id => "1")
      end

      it "routes to #likes" do
        get("/api/v1/replies/1/likes").should route_to("api/v1/replies#likes", :id => "1")
      end
      
      it "routes to #likes_with_parents" do
        get("/api/v1/replies/1/likes/with_parents").should route_to("api/v1/replies#likes_with_parents", :id => "1")
      end

      it "routes to #like" do
        post("/api/v1/replies/1/like").should route_to("api/v1/replies#like", :id => "1")
      end

      it "routes to #unlike" do
        post("/api/v1/replies/1/unlike").should route_to("api/v1/replies#unlike", :id => "1")
      end
    end
    describe "users" do

      it "routes to #show" do
        get("/api/v1/users/1").should route_to("api/v1/users#show", :id => "1")
      end

      it "routes to #with_children" do
        get("/api/v1/users/1/with_children").should route_to("api/v1/users#with_children", :id => "1")
      end

      it "routes to #posts" do
        get("/api/v1/users/1/posts").should route_to("api/v1/users#posts", :id => "1")
      end

      it "routes to #posts_with_parents" do
        get("/api/v1/users/1/posts/with_parents").should route_to("api/v1/users#posts_with_parents", :id => "1")
      end
      
      #it "routes to #batch" do
      #  get("/api/v1/users/batch").should route_to("api/v1/users#batch")
      #end

    end
    describe "topics" do

      it "routes to #show" do
        get("/api/v1/topics/1").should route_to("api/v1/topics#show", :id => "1")
      end

      it "routes to #posts" do
        get("/api/v1/topics/1/posts").should route_to("api/v1/topics#posts", :id => "1")
      end

      it "routes to #posts_with_parents" do
        get("/api/v1/topics/1/posts/with_parents").should route_to("api/v1/topics#posts_with_parents", :id => "1")
      end

      it "routes to #join" do
        post("/api/v1/topics/1/join").should route_to("api/v1/topics#join", :id => "1")
      end

      it "routes to #leave" do
        post("/api/v1/topics/1/leave").should route_to("api/v1/topics#leave", :id => "1")
      end
      
      
      #it "routes to #batch" do
      #  get("/api/v1/topics/batch").should route_to("api/v1/topics#batch")
      #end

    end


  end
end
