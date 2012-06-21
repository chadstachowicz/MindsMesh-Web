require 'spec_helper'

describe "topics/show" do
  before(:each) do
    @topic = assign(:topic, Fabricate(:topic))
    assign(:topic_user, nil)
    assign(:topic_users, [
      Fabricate.build(:topic_user),
      Fabricate.build(:topic_user)
      ])
    assign(:posts, [
      Fabricate(:post),
      Fabricate(:post)
      ])
    controller.stub!(:current_user).and_return(current_user_master)
  end

  it "renders attributes in <p>" do
    render
    view.should render_template("/posts/_posts")
    view.should render_template("/posts/_post")
  end

end
