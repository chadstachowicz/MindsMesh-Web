require 'spec_helper'

describe "entity_user_lms/show" do
  before(:each) do
    @entity_user_lm = assign(:entity_user_lm, stub_model(EntityUserLm,
      :lms_provider_id => 1,
      :user_id => 2,
      :token => "Token"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Token/)
  end
end
