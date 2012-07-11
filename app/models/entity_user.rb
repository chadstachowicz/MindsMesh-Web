class EntityUser < ActiveRecord::Base
  attr_accessible :user
  belongs_to :entity
  belongs_to :user
  # TODO: define or remove these boolean fields
  attr_accessor :b_admin, :b_moderator, :b_student, :b_teacher
  
  validates_presence_of :entity
  validates_presence_of :user
  validates_uniqueness_of :user_id, scope: :entity_id

  after_create :joins_self_joining_entities

  private

  def joins_self_joining_entities
    entity.topics.self_joinings.each { |t| t.user_join(user) }
  end

end
