require 'spec_helper'

describe "posts/_posts" do
  before(:each) do
    
    view.stub!(:title).and_return("my string")
    view.stub!(:posts).and_return([
      Fabricate(:post),
      Fabricate(:post)
      ])
  end

  it "renders" do
    render
  end
end
