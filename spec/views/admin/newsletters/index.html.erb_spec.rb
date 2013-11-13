require 'spec_helper'

describe "admin/newsletters/index" do
  before(:each) do
    assign(:admin_newsletters, [
      stub_model(Admin::Newsletter,
        :title => "Title",
        :plainemail => "MyText",
        :htmlemail => "MyText",
        :status => false
      ),
      stub_model(Admin::Newsletter,
        :title => "Title",
        :plainemail => "MyText",
        :htmlemail => "MyText",
        :status => false
      )
    ])
  end

  it "renders a list of admin/newsletters" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
