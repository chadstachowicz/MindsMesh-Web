require 'spec_helper'

describe "notification_settings/index" do
  before(:each) do
    assign(:notification_settings, [
      stub_model(NotificationSetting,
        :user_id => 1,
        :topic_push_setting_id => 2,
        :topic_email_setting_id => 3,
        :group_push_setting_id => 4,
        :group_email_setting_id => 5,
        :reply_push_setting_id => 6,
        :reply_email_setting_id => 7
      ),
      stub_model(NotificationSetting,
        :user_id => 1,
        :topic_push_setting_id => 2,
        :topic_email_setting_id => 3,
        :group_push_setting_id => 4,
        :group_email_setting_id => 5,
        :reply_push_setting_id => 6,
        :reply_email_setting_id => 7
      )
    ])
  end

  it "renders a list of notification_settings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
  end
end
