class NotificationSetting < ActiveRecord::Base
  attr_accessible :group_email_setting_id, :group_push_setting_id, :reply_email_setting_id, :reply_push_setting_id, :topic_email_setting_id, :topic_push_setting_id, :user_id
end
