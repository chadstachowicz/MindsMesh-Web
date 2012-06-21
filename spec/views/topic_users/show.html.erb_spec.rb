require 'spec_helper'

describe "topic_users/show" do
  before(:each) do
    @topic_user = assign(:topic_user, stub_model(TopicUser,
      :topic => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
  end
end
