require 'spec_helper'

describe "NotificationSettingsTimes" do
  describe "GET /notification_settings_times" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get notification_settings_times_path
      response.status.should be(200)
    end
  end
end