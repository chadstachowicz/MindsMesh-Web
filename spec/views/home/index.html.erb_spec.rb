require 'spec_helper'

describe "home/index.html.erb" do
  
  before do
    assign(:posts, [])
    view.stub!(:current_user).and_return(current_user)
  end

  it "works" do
    render
  end

end
