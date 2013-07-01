require 'spec_helper'

describe "entity_lms/edit" do
  before(:each) do
    @entity_lm = assign(:entity_lm, stub_model(EntityLm,
      :lms_provider_id => 1,
      :entity_id => 1,
      :version => "MyString",
      :host => "MyString",
      :secure => 1,
      :lti-guid => "MyString"
    ))
  end

  it "renders the edit entity_lm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", entity_lm_path(@entity_lm), "post" do
      assert_select "input#entity_lm_lms_provider_id[name=?]", "entity_lm[lms_provider_id]"
      assert_select "input#entity_lm_entity_id[name=?]", "entity_lm[entity_id]"
      assert_select "input#entity_lm_version[name=?]", "entity_lm[version]"
      assert_select "input#entity_lm_host[name=?]", "entity_lm[host]"
      assert_select "input#entity_lm_secure[name=?]", "entity_lm[secure]"
      assert_select "input#entity_lm_lti-guid[name=?]", "entity_lm[lti-guid]"
    end
  end
end
