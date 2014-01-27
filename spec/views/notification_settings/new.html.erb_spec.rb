require 'spec_helper'

describe "notification_settings/new" do
  before(:each) do
    assign(:notification_setting, stub_model(NotificationSetting,
      :user_id => 1,
      :topic_push_setting_id => 1,
      :topic_email_setting_id => 1,
      :group_push_setting_id => 1,
      :group_email_setting_id => 1,
      :reply_push_setting_id => 1,
      :reply_email_setting_id => 1
    ).as_new_record)
  end

  it "renders new notification_setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", notification_settings_path, "post" do
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
