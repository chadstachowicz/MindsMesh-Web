require 'spec_helper'

describe "entities/edit" do
  before(:each) do
    @entity = assign(:entity, stub_model(Entity,
      :name => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit entity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entities_path(@entity), :method => "post" do
      assert_select "input#entity_name", :name => "entity[name]"
      assert_select "input#entity_slug", :name => "entity[slug]"
    end
  end
end
