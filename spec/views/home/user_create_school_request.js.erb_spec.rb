require 'spec_helper'

describe "home/user_create_school_request.js.erb" do

  it "renders the create school_user_requests remote form" do
    current_user = Fabricate(:user)
    cond = { school_id: Fabricate(:school).id, email: "#{Faker::Internet.user_name}@error.edu" }
    @school_user_request = current_user.school_user_requests.where(cond).first_or_initialize
    @school_user_request.save

    render
  end

end
