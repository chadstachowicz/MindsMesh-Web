require 'spec_helper'

describe "home/_feedback.html.erb" do
  it "renders" do
    view.stub!(:current_user).and_return(current_user_user)
    render
  end
end
