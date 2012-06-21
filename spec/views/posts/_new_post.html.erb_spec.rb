require 'spec_helper'

describe "posts/_new_post" do
  it "renders with select tag" do
    view.stub!(:topic_user).and_return(nil)
    view.stub!(:current_user).and_return(current_user_master)
    render
  end

  it "renders with hidden tag" do
    view.stub!(:topic_user).and_return(Fabricate(:topic_user))
    render
  end
end
