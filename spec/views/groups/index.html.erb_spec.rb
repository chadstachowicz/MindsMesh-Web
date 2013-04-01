require 'spec_helper'

describe "groups/index" do
  before(:each) do
    assign(:groups, [
      stub_model(Group,
        :entity_id => 1,
        :name => "Name",
        :slug => "Slug",
        :group_users_count => 2,
        :posts_count => 3,
        :description => "Description",
        :user_id => 4
      ),
      stub_model(Group,
        :entity_id => 1,
        :name => "Name",
        :slug => "Slug",
        :group_users_count => 2,
        :posts_count => 3,
        :description => "Description",
        :user_id => 4
      )
    ])
  end

  it "renders a list of groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
