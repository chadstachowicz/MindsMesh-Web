require 'spec_helper'

describe "EntityUserLms" do
  describe "GET /entity_user_lms" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get entity_user_lms_path
      response.status.should be(200)
    end
  end
end
