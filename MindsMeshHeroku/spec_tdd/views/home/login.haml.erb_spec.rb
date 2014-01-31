require 'spec_helper'

describe "home/login.haml" do
  it "renders a login with facebook link" do
  	render
  	assert_select "a", :href => "/auth/facebook"
  end
end
