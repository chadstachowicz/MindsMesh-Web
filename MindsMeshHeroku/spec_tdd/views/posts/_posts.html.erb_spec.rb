require 'spec_helper'

describe "posts/_posts" do
  before(:each) do
    view.stub!(:title).and_return("my string")
    controller.stub!(:current_user).and_return(current_user_master)
  end

  it "renders _post" do
    view.stub!(:posts).and_return([])
    render
    #view.should_not render_template("posts/_post")
  end

  it "renders _post" do
    view.stub!(:posts).and_return([
      Fabricate(:post),
      Fabricate(:post)
      ])
    render
    view.should render_template("posts/_post")
  end
  
end
