require 'spec_helper'

describe "email_campaigns/index" do
  before(:each) do
    assign(:email_campaigns, [
      stub_model(EmailCampaign,
        :name => "Name",
        :type => "Type",
        :entity_id => 1,
        :emails_sent => 2,
        :emails_responded => 3,
        :status => "Status"
      ),
      stub_model(EmailCampaign,
        :name => "Name",
        :type => "Type",
        :entity_id => 1,
        :emails_sent => 2,
        :emails_responded => 3,
        :status => "Status"
      )
    ])
  end

  it "renders a list of email_campaigns" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
