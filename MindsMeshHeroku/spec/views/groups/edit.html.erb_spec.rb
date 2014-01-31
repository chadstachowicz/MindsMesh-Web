require 'spec_helper'

describe "groups/edit" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :entity_id => 1,
      :name => "MyString",
      :slug => "MyString",
      :group_users_count => 1,
      :posts_count => 1,
      :description => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", group_path(@group), "post" do
      assert_select "input#group_entity_id[name=?]", "group[entity_id]"
      assert_select "input#group_name[name=?]", "group[name]"
      assert_select "input#group_slug[name=?]", "group[slug]"
      assert_select "input#group_group_users_count[name=?]", "group[group_users_count]"
      assert_select "input#group_posts_count[name=?]", "group[posts_count]"
      assert_select "input#group_description[name=?]", "group[description]"
      assert_select "input#group_user_id[name=?]", "group[user_id]"
    end
  end
end
