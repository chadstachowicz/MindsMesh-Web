require 'spec_helper'

describe "topics/new" do
  before(:each) do
    assign(:topic, stub_model(Topic,
      :entity => nil,
      :name => "MyString",
      :slug => "MyString"
    ).as_new_record)
  end

  it "renders new topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => topics_path, :method => "post" do
      assert_select "select#topic_entity_user_id"
      assert_select "input#topic_name", :name => "topic[name]"
      assert_select "input#topic_slug", :name => "topic[slug]"
    end
  end
end
