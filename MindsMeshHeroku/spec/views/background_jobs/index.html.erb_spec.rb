require 'spec_helper'

describe "background_jobs/index" do
  before(:each) do
    assign(:background_jobs, [
      stub_model(BackgroundJob,
        :name => "Name",
        :type => "Type",
        :entity_id => 1,
        :transactions => 2,
        :campaign_id => 3,
        :status => "Status"
      ),
      stub_model(BackgroundJob,
        :name => "Name",
        :type => "Type",
        :entity_id => 1,
        :transactions => 2,
        :campaign_id => 3,
        :status => "Status"
      )
    ])
  end

  it "renders a list of background_jobs" do
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
