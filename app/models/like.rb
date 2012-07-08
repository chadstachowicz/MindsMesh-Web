class Like < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :likable, polymorphic: true, counter_cache: true
  attr_accessible :user, :likable

  validates_presence_of :user
  validates_presence_of :likable
  validates_uniqueness_of :user_id, scope: [:likable_type, :likable_id]

  after_create do
    Notification.notify_owner(likable.user_id,
                              likable,
                              Notification::ACTION_LIKED,
                              likable.likes.count
                              )
  end

end
