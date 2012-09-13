class TopicUser < ActiveRecord::Base
  belongs_to :topic, counter_cache: true
  belongs_to :user, counter_cache: true

  attr_accessible :topic_id, :entity_user_id # :role, :user_id

  validates_presence_of :topic
  validates_presence_of :user
  validates_presence_of :entity_user, on: :creation
  validates_uniqueness_of :user_id, scope: :topic_id

  attr_accessor :entity_user, :entity_user_id
  before_validation :set_entity_user_correctly, on: :create

  def set_entity_user_correctly
    if entity_user_id
      self.entity_user=EntityUser.find(entity_user_id)
    end
    if entity_user
      self.user    = entity_user.user
    end
  end

  #ROLES = ['teacher', 'moderator', nil]
  #validates_inclusion_of :role, in: ROLES

  #def role_s
  #  role || "student"
  #end
end
