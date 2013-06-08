class TopicUser < ActiveRecord::Base
  belongs_to :topic, counter_cache: true
  belongs_to :user, counter_cache: true

    attr_accessible :topic_id, :topic_user_id, :role_i

  validates_presence_of :topic
  validates_presence_of :user
  validates_presence_of :topic_user, on: :creation
  validates_uniqueness_of :user_id, scope: :topic_id


end
