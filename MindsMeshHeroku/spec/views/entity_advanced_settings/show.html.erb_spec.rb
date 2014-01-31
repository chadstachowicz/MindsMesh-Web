require 'spec_helper'

describe "entity_advanced_settings/show" do
  before(:each) do
    @entity_advanced_setting = assign(:entity_advanced_setting, stub_model(EntityAdvancedSetting,
      :lti_consumer_key => "Lti Consumer Key"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Lti Consumer Key/)
  end
end
