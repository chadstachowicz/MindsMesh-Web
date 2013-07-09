require 'spec_helper'

describe "hashtags/index" do
  before(:each) do
    assign(:hashtags, [
      stub_model(Hashtag,
        :entity_id => 1,
        :name => "Name"
      ),
      stub_model(Hashtag,
        :entity_id => 1,
        :name => "Name"
      )
    ])
  end

  it "renders a list of hashtags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
