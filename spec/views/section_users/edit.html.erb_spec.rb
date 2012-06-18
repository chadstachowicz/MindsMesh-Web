require 'spec_helper'

describe "section_users/edit" do
  before(:each) do
    @section_user = assign(:section_user, stub_model(SectionUser,
      :section => nil,
      :user => nil
    ))
  end

  it "renders the edit section_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => section_users_path(@section_user), :method => "post" do
      assert_select "input#section_user_section_id", :name => "section_user[section_id]"
      assert_select "input#section_user_user_id", :name => "section_user[user_id]"
    end
  end
end
