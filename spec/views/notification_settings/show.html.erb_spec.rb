require 'spec_helper'

describe "notification_settings/show" do
  before(:each) do
    @notification_setting = assign(:notification_setting, stub_model(NotificationSetting,
      :user_id => 1,
      :topic_push_setting_id => 2,
      :topic_email_setting_id => 3,
      :group_push_setting_id => 4,
      :group_email_setting_id => 5,
      :reply_push_setting_id => 6,
      :reply_email_setting_id => 7
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/7/)
  end
end
