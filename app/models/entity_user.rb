class EntityUser < ActiveRecord::Base
    attr_accessible :user_id, :entity_id, :user, :role_i
  belongs_to :entity, counter_cache: true
  belongs_to :user, counter_cache: true
  # TODO: define or remove these boolean fields
  attr_accessor :b_admin, :b_moderator, :b_student, :b_teacher
  
  validates_presence_of :entity
  validates_presence_of :user
  validates_uniqueness_of :user_id, scope: :entity_id

  class << self
    def eu(entity_id, user_id)
      find_by_entity_id_and_user_id(entity_id, user_id) || :entity_user_not_found
    end
  end
  
  #untested
  def joins_self_joinings_topics
    entity.topics.self_joinings.each { |t| t.user_join(self) }
  end
=begin
  after_create :joins_self_joining_topics

  private

  def joins_self_joining_topics
    entity.topics.self_joinings.each { |t| t.user_join(self) }
  end
=end
end
