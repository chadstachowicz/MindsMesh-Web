require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = Fabricate(:user) { posts count: 3 }
    assign(:posts, @user.posts)
    assign(:topic_users, @user.topic_users)#zero items :()

    controller.stub!(:current_user).and_return(current_user)
  end

  it "renders" do
    render
  end
end
