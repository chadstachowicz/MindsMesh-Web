require 'spec_helper'

describe "posts/show" do
  before(:each) do
    @post = assign(:post, Fabricate(:post))
  end

  it "renders" do
    render
    #same as _post, for the post part
  end
end
