require 'spec_helper'

describe "schools/edit" do
  before(:each) do
    @school = assign(:school, stub_model(School,
      :name => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit school form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => schools_path(@school), :method => "post" do
      assert_select "input#school_name", :name => "school[name]"
      assert_select "input#school_slug", :name => "school[slug]"
    end
  end
end
