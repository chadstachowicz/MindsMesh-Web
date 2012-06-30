require 'spec_helper'

describe "home/guest.html.erb" do
  it "renders a login with facebook link" do
  	render
  	assert_select "a", :href => "/auth/facebook"
  end
end
