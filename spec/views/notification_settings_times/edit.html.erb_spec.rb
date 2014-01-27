require 'spec_helper'

describe "notification_settings_times/edit" do
  before(:each) do
    @notification_settings_time = assign(:notification_settings_time, stub_model(NotificationSettingsTime,
      :description => "MyString"
    ))
  end

  it "renders the edit notification_settings_time form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", notification_settings_time_path(@notification_settings_time), "post" do
      assert_select "input#notification_settings_time_description[name=?]", "notification_settings_time[description]"
    end
  end
end
