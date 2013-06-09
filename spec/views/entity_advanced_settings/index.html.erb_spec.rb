require 'spec_helper'

describe "entity_advanced_settings/index" do
  before(:each) do
    assign(:entity_advanced_settings, [
      stub_model(EntityAdvancedSetting,
        :lti_consumer_key => "Lti Consumer Key"
      ),
      stub_model(EntityAdvancedSetting,
        :lti_consumer_key => "Lti Consumer Key"
      )
    ])
  end

  it "renders a list of entity_advanced_settings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Lti Consumer Key".to_s, :count => 2
  end
end
