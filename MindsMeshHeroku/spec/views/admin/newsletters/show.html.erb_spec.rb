require 'spec_helper'

describe "admin/newsletters/show" do
  before(:each) do
    @admin_newsletter = assign(:admin_newsletter, stub_model(Admin::Newsletter,
      :title => "Title",
      :plainemail => "MyText",
      :htmlemail => "MyText",
      :status => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
  end
end
