require 'spec_helper'

describe "section_users/index" do
  before(:each) do
    assign(:section_users, [
      stub_model(SectionUser,
        :section => nil,
        :user => nil,
        :b_moderator => false,
        :b_teacher => false
      ),
      stub_model(SectionUser,
        :section => nil,
        :user => nil,
        :b_moderator => false,
        :b_teacher => false
      )
    ])
  end

  it "renders a list of section_users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
