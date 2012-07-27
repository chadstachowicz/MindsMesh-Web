require 'spec_helper'

describe "home/user.haml" do

  it "renders the edit user form" do
    render

    assert_select "form", action: home_user_create_eur_path, method: "post", remote: true do
      assert_select "input#email"
    end
  end

end
