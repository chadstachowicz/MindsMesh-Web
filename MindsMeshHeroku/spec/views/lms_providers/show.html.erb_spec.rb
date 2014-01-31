require 'spec_helper'

describe "lms_providers/show" do
  before(:each) do
    @lms_provider = assign(:lms_provider, stub_model(LmsProvider,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
