require 'spec_helper'

describe "home/entities.haml" do

  it "renders the edit user form" do
    render

    assert_select "form", action: home_create_entity_request_path, method: "post", remote: true do
      assert_select "input#email"
    end
  end

end
