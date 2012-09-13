require "spec_helper"

describe TopicUsersController do
  describe "routing" do

    it "routes to #index" do
      get("/topic_users").should route_to("topic_users#index")
    end

    it "routes to #new" do
      get("/topic_users/new").should route_to("topic_users#new")
    end

    it "routes to #show" do
      get("/topic_users/1").should route_to("topic_users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/topic_users/1/edit").should route_to("topic_users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/topic_users").should route_to("topic_users#create")
    end

    it "routes to #update" do
      put("/topic_users/1").should route_to("topic_users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/topic_users/1").should route_to("topic_users#destroy", :id => "1")
    end

  end
end
