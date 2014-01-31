require "spec_helper"

describe PagesController do
  describe "routing" do

    %w{privacy}.each do |pg|
      it "routes to ##{pg}" do
        get("/#{pg}").should route_to("pages##{pg}")
      end
    end
    %w{about faq support terms}.each do |pg|
      it "routes to ##{pg}" do
        get("/#{pg}").should route_to("pages#privacy")
      end
    end

  end
end
