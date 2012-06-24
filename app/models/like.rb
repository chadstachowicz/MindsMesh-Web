class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likable, polymorphic: true
  attr_accessible :user, :likable

  validates_presence_of :user
  validates_presence_of :likable
  validates_uniqueness_of :user_id, scope: [:likable_type, :likable_id]
end
