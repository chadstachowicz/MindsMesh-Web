require 'spec_helper'

describe "groups/show" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :entity_id => 1,
      :name => "Name",
      :slug => "Slug",
      :group_users_count => 2,
      :posts_count => 3,
      :description => "Description",
      :user_id => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/Slug/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Description/)
    rendered.should match(/4/)
  end
end
