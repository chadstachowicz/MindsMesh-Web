require 'spec_helper'

describe "email_campaigns/edit" do
  before(:each) do
    @email_campaign = assign(:email_campaign, stub_model(EmailCampaign,
      :name => "MyString",
      :type => "",
      :entity_id => 1,
      :emails_sent => 1,
      :emails_responded => 1,
      :status => "MyString"
    ))
  end

  it "renders the edit email_campaign form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", email_campaign_path(@email_campaign), "post" do
      assert_select "input#email_campaign_name[name=?]", "email_campaign[name]"
      assert_select "input#email_campaign_type[name=?]", "email_campaign[type]"
      assert_select "input#email_campaign_entity_id[name=?]", "email_campaign[entity_id]"
      assert_select "input#email_campaign_emails_sent[name=?]", "email_campaign[emails_sent]"
      assert_select "input#email_campaign_emails_responded[name=?]", "email_campaign[emails_responded]"
      assert_select "input#email_campaign_status[name=?]", "email_campaign[status]"
    end
  end
end
