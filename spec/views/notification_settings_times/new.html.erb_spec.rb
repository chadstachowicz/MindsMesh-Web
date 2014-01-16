require 'spec_helper'

describe "notification_settings_times/new" do
  before(:each) do
    assign(:notification_settings_time, stub_model(NotificationSettingsTime,
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new notification_settings_time form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", notification_settings_times_path, "post" do
      assert_select "input#notification_settings_time_description[name=?]", "notification_settings_time[description]"
    end
  end
end