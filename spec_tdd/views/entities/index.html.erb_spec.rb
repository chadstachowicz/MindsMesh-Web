require 'spec_helper'

describe "entities/index" do
  before(:each) do
    assign(:entities, [
      stub_model(Entity,
        :name => "Name",
        :slug => "Slug"
      ),
      stub_model(Entity,
        :name => "Name",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of entities" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
