require 'spec_helper'

describe "posts/_new_post" do
  it "renders with select modal" do
    view.stub!(:topic_user).and_return(nil)
    view.stub!(:current_user).and_return(current_user_master)
    render
    assert_select "#new_post_modal"
  end

  it "renders with hidden tag" do
    view.stub!(:topic_user).and_return(Fabricate(:topic_user))
    render
    assert_select "input#post_topic_user_id", type: "hidden"
  end
end
