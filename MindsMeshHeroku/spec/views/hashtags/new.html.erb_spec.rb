require 'spec_helper'

describe "hashtags/new" do
  before(:each) do
    assign(:hashtag, stub_model(Hashtag,
      :entity_id => 1,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new hashtag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", hashtags_path, "post" do
      assert_select "input#hashtag_entity_id[name=?]", "hashtag[entity_id]"
      assert_select "input#hashtag_name[name=?]", "hashtag[name]"
    end
  end
end
