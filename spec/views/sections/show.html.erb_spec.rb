require 'spec_helper'

describe "sections/show" do
  before(:each) do
    @section = assign(:section, stub_model(Section,
      :course => nil,
      :school => nil,
      :name => "Name",
      :slug => "Slug"
    ))
    assign(:section_user, nil)
    assign(:section_users, [
      Fabricate.build(:section_user),
      Fabricate.build(:section_user)
      ])
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Name/)
    rendered.should match(/Slug/)
  end
end
