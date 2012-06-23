require 'spec_helper'

describe "posts/_posts" do
  before(:each) do
    view.stub!(:title).and_return("my string")
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
