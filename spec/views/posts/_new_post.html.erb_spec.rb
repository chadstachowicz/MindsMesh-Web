require 'spec_helper'

describe "posts/_new_post" do
  it "renders with select tag" do
    view.stub!(:topic_user).and_return(nil)
    view.stub!(:current_user).and_return(current_user_master)
    render
    assert_select "select#topic_user_id", text: "Select a Course"
  end

  it "renders with hidden tag" do
    view.stub!(:topic_user).and_return(Fabricate(:topic_user))
    render
    assert_select "input#topic_user_id", type: "hidden"
  end
end
