require 'spec_helper'

describe "lms_providers/index" do
  before(:each) do
    assign(:lms_providers, [
      stub_model(LmsProvider,
        :name => "Name"
      ),
      stub_model(LmsProvider,
        :name => "Name"
      )
    ])
  end

  it "renders a list of lms_providers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
