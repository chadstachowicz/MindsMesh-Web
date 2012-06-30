require "spec_helper"

describe QuestionnairesController do
  describe "routing" do

    it "routes to #index" do
      get("/questionnaires").should route_to("questionnaires#index")
    end

    it "routes to #show" do
      get("/questionnaires/1").should route_to("questionnaires#show", :id => "1")
    end

    it "routes to #destroy" do
      delete("/questionnaires/1").should route_to("questionnaires#destroy", :id => "1")
    end

  end
end
