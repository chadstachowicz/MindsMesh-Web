require 'spec_helper'

describe "notification_settings_times/index" do
  before(:each) do
    assign(:notification_settings_times, [
      stub_model(NotificationSettingsTime,
        :description => "Description"
      ),
      stub_model(NotificationSettingsTime,
        :description => "Description"
      )
    ])
  end

  it "renders a list of notification_settings_times" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
