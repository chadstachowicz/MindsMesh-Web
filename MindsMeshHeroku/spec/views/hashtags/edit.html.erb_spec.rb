require 'spec_helper'

describe "hashtags/edit" do
  before(:each) do
    @hashtag = assign(:hashtag, stub_model(Hashtag,
      :entity_id => 1,
      :name => "MyString"
    ))
  end

  it "renders the edit hashtag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", hashtag_path(@hashtag), "post" do
      assert_select "input#hashtag_entity_id[name=?]", "hashtag[entity_id]"
      assert_select "input#hashtag_name[name=?]", "hashtag[name]"
    end
  end
end
