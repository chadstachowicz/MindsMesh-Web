require 'spec_helper'

describe "posts/show" do
  before(:each) do
    @post = assign(:post, Fabricate(:post))
    controller.stub!(:current_user).and_return(current_user_master)
  end

  it "renders" do
    render
    #same as _post, for the post part
  end
end
