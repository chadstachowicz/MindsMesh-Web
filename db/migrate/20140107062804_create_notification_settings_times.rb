class CreateNotificationSettingsTimes < ActiveRecord::Migration
  def change
    create_table :notification_settings_times do |t|
      t.string :description

      t.timestamps
    end
  end
end
