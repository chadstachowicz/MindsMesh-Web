require 'spec_helper'

describe "invite_requests/index" do
  before(:each) do
    assign(:invite_requests, [
      stub_model(InviteRequest,
        :user => nil,
        :entity => nil,
        :topic => nil
      ),
      stub_model(InviteRequest,
        :user => nil,
        :entity => nil,
        :topic => nil
      )
    ])
  end

  it "renders a list of invite_requests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
