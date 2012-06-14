require 'spec_helper'

describe "home/user.html.erb" do

  it "renders the edit user form" do
    @school = Fabricate(:school)
    @school_user_request = @school.school_user_requests.build

    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", action: home_user_path, method: "post", remote: true do
      assert_select "input#school_user_request_school_id", :name => "school_user_request[school_id]"
      assert_select "input#school_user_request_email", :name => "school_user_request[email]"
    end
  end

end
