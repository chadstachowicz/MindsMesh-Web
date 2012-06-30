require 'spec_helper'

describe "home/user_create_eur.js.erb" do

  it "renders the create entity_user_requests remote form" do
    current_user = Fabricate(:user)
    cond = { entity_id: Fabricate(:entity).id, email: "#{Faker::Internet.user_name}@error.edu" }
    @entity_user_request = current_user.entity_user_requests.where(cond).first_or_initialize
    @entity_user_request.save

    render
  end

end
