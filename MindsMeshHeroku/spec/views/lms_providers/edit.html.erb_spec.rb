require 'spec_helper'

describe "lms_providers/edit" do
  before(:each) do
    @lms_provider = assign(:lms_provider, stub_model(LmsProvider,
      :name => "MyString"
    ))
  end

  it "renders the edit lms_provider form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lms_provider_path(@lms_provider), "post" do
      assert_select "input#lms_provider_name[name=?]", "lms_provider[name]"
    end
  end
end
