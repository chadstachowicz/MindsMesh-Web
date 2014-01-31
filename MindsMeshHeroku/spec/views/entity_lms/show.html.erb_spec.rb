require 'spec_helper'

describe "entity_lms/show" do
  before(:each) do
    @entity_lm = assign(:entity_lm, stub_model(EntityLm,
      :lms_provider_id => 1,
      :entity_id => 2,
      :version => "Version",
      :host => "Host",
      :secure => 3,
      :lti-guid => "Lti Guid"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Version/)
    rendered.should match(/Host/)
    rendered.should match(/3/)
    rendered.should match(/Lti Guid/)
  end
end
