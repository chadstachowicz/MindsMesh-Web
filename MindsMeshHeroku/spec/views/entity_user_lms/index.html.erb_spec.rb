require 'spec_helper'

describe "entity_user_lms/index" do
  before(:each) do
    assign(:entity_user_lms, [
      stub_model(EntityUserLm,
        :lms_provider_id => 1,
        :user_id => 2,
        :token => "Token"
      ),
      stub_model(EntityUserLm,
        :lms_provider_id => 1,
        :user_id => 2,
        :token => "Token"
      )
    ])
  end

  it "renders a list of entity_user_lms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
  end
end
