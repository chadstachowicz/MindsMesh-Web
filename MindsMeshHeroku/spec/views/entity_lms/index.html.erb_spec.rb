require 'spec_helper'

describe "entity_lms/index" do
  before(:each) do
    assign(:entity_lms, [
      stub_model(EntityLm,
        :lms_provider_id => 1,
        :entity_id => 2,
        :version => "Version",
        :host => "Host",
        :secure => 3,
        :lti-guid => "Lti Guid"
      ),
      stub_model(EntityLm,
        :lms_provider_id => 1,
        :entity_id => 2,
        :version => "Version",
        :host => "Host",
        :secure => 3,
        :lti-guid => "Lti Guid"
      )
    ])
  end

  it "renders a list of entity_lms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Version".to_s, :count => 2
    assert_select "tr>td", :text => "Host".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Lti Guid".to_s, :count => 2
  end
end
