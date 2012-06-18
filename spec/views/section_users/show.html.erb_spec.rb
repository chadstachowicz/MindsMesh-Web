require 'spec_helper'

describe "section_users/show" do
  before(:each) do
    @section_user = assign(:section_user, stub_model(SectionUser,
      :section => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
  end
end
