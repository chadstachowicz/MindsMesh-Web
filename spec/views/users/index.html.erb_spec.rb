require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :id => rand(9999),
        :name => "Name",
        :photo_url => "Photo Url",
        :created_at => Time.now
      ),
      stub_model(User,
        :id => rand(9999),
        :name => "Name",
        :photo_url => "Photo Url",
        :created_at => Time.now
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td img", count: 2
  end
end
