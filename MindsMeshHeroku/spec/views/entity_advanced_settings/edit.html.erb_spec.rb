require 'spec_helper'

describe "entity_advanced_settings/edit" do
  before(:each) do
    @entity_advanced_setting = assign(:entity_advanced_setting, stub_model(EntityAdvancedSetting,
      :lti_consumer_key => "MyString"
    ))
  end

  it "renders the edit entity_advanced_setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", entity_advanced_setting_path(@entity_advanced_setting), "post" do
      assert_select "input#entity_advanced_setting_lti_consumer_key[name=?]", "entity_advanced_setting[lti_consumer_key]"
    end
  end
end
