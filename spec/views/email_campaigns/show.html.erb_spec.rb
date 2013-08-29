require 'spec_helper'

describe "email_campaigns/show" do
  before(:each) do
    @email_campaign = assign(:email_campaign, stub_model(EmailCampaign,
      :name => "Name",
      :type => "Type",
      :entity_id => 1,
      :emails_sent => 2,
      :emails_responded => 3,
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Type/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Status/)
  end
end
