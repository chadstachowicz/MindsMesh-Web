require 'spec_helper'

describe "notification_settings/edit" do
  before(:each) do
    @notification_setting = assign(:notification_setting, stub_model(NotificationSetting,
      :user_id => 1,
      :topic_push_setting_id => 1,
      :topic_email_setting_id => 1,
      :group_push_setting_id => 1,
      :group_email_setting_id => 1,
      :reply_push_setting_id => 1,
      :reply_email_setting_id => 1
    ))
  end

  it "renders the edit notification_setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", notification_setting_path(@notification_setting), "post" do
      assert_select "input#notification_setting_user_id[name=?]", "notification_setting[user_id]"
      assert_select "input#notification_setting_topic_push_setting_id[name=?]", "notification_setting[topic_push_setting_id]"
      assert_select "input#notification_setting_topic_email_setting_id[name=?]", "notification_setting[topic_email_setting_id]"
      assert_select "input#notification_setting_group_push_setting_id[name=?]", "notification_setting[group_push_setting_id]"
      assert_select "input#notification_setting_group_email_setting_id[name=?]", "notification_setting[group_email_setting_id]"
      assert_select "input#notification_setting_reply_push_setting_id[name=?]", "notification_setting[reply_push_setting_id]"
      assert_select "input#notification_setting_reply_email_setting_id[name=?]", "notification_setting[reply_email_setting_id]"
    end
  end
end
