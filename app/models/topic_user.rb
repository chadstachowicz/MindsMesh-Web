class TopicUser < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :posts
  attr_accessible :role, :topic_id, :user_id
  validates_presence_of :topic
  validates_presence_of :user
  validates_uniqueness_of :user_id, scope: :topic_id

  ROLES = ['teacher', 'moderator', nil]
  validates_inclusion_of :role, in: ROLES

  def role_s
    role || "student"
  end
end
