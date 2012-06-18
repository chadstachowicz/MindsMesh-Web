require 'spec_helper'

describe "section_users/index" do
  before(:each) do
    assign(:section_users, [
      stub_model(SectionUser,
        :section => nil,
        :user => nil
      ),
      stub_model(SectionUser,
        :section => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of section_users" do
    render
  end
end
