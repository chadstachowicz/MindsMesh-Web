require 'spec_helper'

describe "notification_settings_times/show" do
  before(:each) do
    @notification_settings_time = assign(:notification_settings_time, stub_model(NotificationSettingsTime,
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
  end
end
