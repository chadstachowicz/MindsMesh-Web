require 'spec_helper'

describe "entity_user_lms/new" do
  before(:each) do
    assign(:entity_user_lm, stub_model(EntityUserLm,
      :lms_provider_id => 1,
      :user_id => 1,
      :token => "MyString"
    ).as_new_record)
  end

  it "renders new entity_user_lm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", entity_user_lms_path, "post" do
      assert_select "input#entity_user_lm_lms_provider_id[name=?]", "entity_user_lm[lms_provider_id]"
      assert_select "input#entity_user_lm_user_id[name=?]", "entity_user_lm[user_id]"
      assert_select "input#entity_user_lm_token[name=?]", "entity_user_lm[token]"
    end
  end
end
