require 'spec_helper'

describe "invite_requests/new" do
  before(:each) do
    assign(:invite_request, stub_model(InviteRequest,
      :user => nil,
      :entity => nil,
      :topic => nil
    ).as_new_record)
  end

  it "renders new invite_request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => invite_requests_path, :method => "post" do
      assert_select "input#invite_request_user", :name => "invite_request[user]"
      assert_select "input#invite_request_entity", :name => "invite_request[entity]"
      assert_select "input#invite_request_topic", :name => "invite_request[topic]"
    end
  end
end
