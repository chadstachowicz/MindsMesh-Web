require 'spec_helper'

describe "EmailCampaigns" do
  describe "GET /email_campaigns" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get email_campaigns_path
      response.status.should be(200)
    end
  end
end
