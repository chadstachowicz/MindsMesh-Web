require 'spec_helper'

describe "topics/show" do
  pending "test views with mocks is faster"
=begin
  before(:each) do
    @topic = assign(:topic, Fabricate(:topic))
    assign(:topic_users, [
      Fabricate.build(:topic_user),
      Fabricate.build(:topic_user)
      ])
    assign(:posts, [
      Fabricate(:post),
      Fabricate(:post)
      ])
    controller.stub!(:current_user).and_return(current_user_master)
    view.stub!(:current_user).and_return(current_user_master)
  end

  it "renders a topic I did not joined" do
    assign(:topic_user, nil)
    render
    view.should render_template("/posts/_posts")
    view.should render_template("/posts/_post")
    view.should_not render_template("/posts/_new_post")
  end

  it "renders a topic I joined" do
    assign(:topic_user, Fabricate(:topic_user, topic: @topic, user: current_user_master))
    render
    view.should render_template("/posts/_posts")
    view.should render_template("/posts/_post")
    view.should render_template("/posts/_new_post")
  end

=end
end