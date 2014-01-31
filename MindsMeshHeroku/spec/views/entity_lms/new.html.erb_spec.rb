require 'spec_helper'

describe "entity_lms/new" do
  before(:each) do
    assign(:entity_lm, stub_model(EntityLm,
      :lms_provider_id => 1,
      :entity_id => 1,
      :version => "MyString",
      :host => "MyString",
      :secure => 1,
      :lti-guid => "MyString"
    ).as_new_record)
  end

  it "renders new entity_lm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", entity_lms_path, "post" do
      assert_select "input#entity_lm_lms_provider_id[name=?]", "entity_lm[lms_provider_id]"
      assert_select "input#entity_lm_entity_id[name=?]", "entity_lm[entity_id]"
      assert_select "input#entity_lm_version[name=?]", "entity_lm[version]"
      assert_select "input#entity_lm_host[name=?]", "entity_lm[host]"
      assert_select "input#entity_lm_secure[name=?]", "entity_lm[secure]"
      assert_select "input#entity_lm_lti-guid[name=?]", "entity_lm[lti-guid]"
    end
  end
end
