require 'spec_helper'

describe "posts/_post" do
  before(:each) do
    view.stub!(:post).and_return(Fabricate(:post))
  end

  it "renders" do
    render
  end
end
