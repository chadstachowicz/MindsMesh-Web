class CreateNotificationSettings < ActiveRecord::Migration
  def change
    create_table :notification_settings do |t|
      t.integer :user_id
      t.integer :topic_push_setting_id
      t.integer :topic_email_setting_id
      t.integer :group_push_setting_id
      t.integer :group_email_setting_id
      t.integer :reply_push_setting_id
      t.integer :reply_email_setting_id

      t.timestamps
    end
  end
end
