require 'spec_helper'

describe "lms_providers/new" do
  before(:each) do
    assign(:lms_provider, stub_model(LmsProvider,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new lms_provider form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lms_providers_path, "post" do
      assert_select "input#lms_provider_name[name=?]", "lms_provider[name]"
    end
  end
end
