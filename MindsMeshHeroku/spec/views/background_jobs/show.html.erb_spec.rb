require 'spec_helper'

describe "background_jobs/show" do
  before(:each) do
    @background_job = assign(:background_job, stub_model(BackgroundJob,
      :name => "Name",
      :type => "Type",
      :entity_id => 1,
      :transactions => 2,
      :campaign_id => 3,
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
