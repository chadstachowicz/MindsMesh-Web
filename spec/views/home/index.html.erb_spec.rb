require 'spec_helper'

describe "home/index.html.erb" do
  
  before do
    assign(:posts, [])
    view.stub!(:current_user).and_return(current_user)
    controller.stub!(:current_user).and_return(current_user)
  end

  it "renders templates without posts" do
    render
    view.should render_template("posts/_posts")
  end

  it "renders templates with posts" do
    assign(:posts, [Fabricate(:post)])
    render
    view.should render_template("posts/_posts")
  end

  it "does not render new_post when user has no topics" do
    render
    view.should_not render_template("posts/_new_post")
  end

  it "renders new_post when user has topics" do
    Fabricate(:topic_user, user: current_user)
    current_user.reload
    view.stub!(:current_user).and_return(current_user)
    controller.stub!(:current_user).and_return(current_user)
    render
    rendered.should include("content for when you have not joined any topics")
  end

end
