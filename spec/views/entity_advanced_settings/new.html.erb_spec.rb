require 'spec_helper'

describe "entity_advanced_settings/new" do
  before(:each) do
    assign(:entity_advanced_setting, stub_model(EntityAdvancedSetting,
      :lti_consumer_key => "MyString"
    ).as_new_record)
  end

  it "renders new entity_advanced_setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", entity_advanced_settings_path, "post" do
      assert_select "input#entity_advanced_setting_lti_consumer_key[name=?]", "entity_advanced_setting[lti_consumer_key]"
    end
  end
end
