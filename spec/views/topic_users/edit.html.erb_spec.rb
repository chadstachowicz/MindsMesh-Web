require 'spec_helper'

describe "topic_users/edit" do
  before(:each) do
    @topic_user = assign(:topic_user, stub_model(TopicUser,
      :topic => nil,
      :user => nil
    ))
  end

  it "renders the edit topic_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => topic_users_path(@topic_user), :method => "post" do
      assert_select "input#topic_user_topic_id", :name => "topic_user[topic_id]"
      assert_select "input#topic_user_user_id", :name => "topic_user[user_id]"
    end
  end
end
