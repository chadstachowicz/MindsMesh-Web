require 'spec_helper'

describe "invite_requests/show" do
  before(:each) do
    @invite_request = assign(:invite_request, stub_model(InviteRequest,
      :user => nil,
      :entity => nil,
      :topic => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
