require 'spec_helper'

describe "home/user.haml" do
  pending "this view cannot be tested because of content_for :full"
  it "" do
    true.should =="this logic should consider any university, not only UNCC"
  end
=begin
  it "renders the edit user form" do
    @entity = Fabricate(:entity)
    @entity_user_request = @entity.entity_user_requests.build

    render

    assert_select "form", action: home_user_create_eur_path, method: "post", remote: true do
      assert_select "input#entity_user_request_entity_id", :name => "entity_user_request[entity_id]"
      assert_select "input#entity_user_request_email", :name => "entity_user_request[email]"
    end
  end
=end
end
