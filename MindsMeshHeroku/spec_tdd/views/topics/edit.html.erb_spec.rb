require 'spec_helper'

describe "topics/edit" do
  before(:each) do
    @topic = assign(:topic, stub_model(Topic,
      :entity => stub_model(Entity, name: "lalala"),
      :name => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => topics_path(@topic), :method => "post" do
      assert_select "select#topic_entity_user_id", count: 0
      assert_select "input#topic_name", :name => "topic[name]"
      assert_select "input#topic_slug", :name => "topic[slug]"
      assert_select "input#topic_title", :name => "topic[title]"
      assert_select "input#topic_number", :name => "topic[number]"
      assert_select "input#topic_self_joining", :name => "topic[self_joining]"
    end
  end
end
