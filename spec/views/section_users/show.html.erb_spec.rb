require 'spec_helper'

describe "section_users/show" do
  before(:each) do
    @section_user = assign(:section_user, stub_model(SectionUser,
      :section => nil,
      :user => nil,
      :b_moderator => false,
      :b_teacher => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
