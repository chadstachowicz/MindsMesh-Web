require 'spec_helper'

describe "entities/new" do
  before(:each) do
    assign(:entity, stub_model(Entity,
      :name => "MyString",
      :slug => "MyString"
    ).as_new_record)
  end

  it "renders new entity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entities_path, :method => "post" do
      assert_select "input#entity_name", :name => "entity[name]"
      assert_select "input#entity_slug", :name => "entity[slug]"
    end
  end
end
