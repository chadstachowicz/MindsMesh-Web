require 'spec_helper'

describe "topic_users/index" do
  before(:each) do
    assign(:topic_users, [
      stub_model(TopicUser,
        :topic => nil,
        :user => nil
      ),
      stub_model(TopicUser,
        :topic => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of topic_users" do
    render
  end
end
