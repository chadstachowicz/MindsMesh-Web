require 'spec_helper'

describe "admin/newsletters/edit" do
  before(:each) do
    @admin_newsletter = assign(:admin_newsletter, stub_model(Admin::Newsletter,
      :title => "MyString",
      :plainemail => "MyText",
      :htmlemail => "MyText",
      :status => false
    ))
  end

  it "renders the edit admin_newsletter form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_newsletter_path(@admin_newsletter), "post" do
      assert_select "input#admin_newsletter_title[name=?]", "admin_newsletter[title]"
      assert_select "textarea#admin_newsletter_plainemail[name=?]", "admin_newsletter[plainemail]"
      assert_select "textarea#admin_newsletter_htmlemail[name=?]", "admin_newsletter[htmlemail]"
      assert_select "input#admin_newsletter_status[name=?]", "admin_newsletter[status]"
    end
  end
end
