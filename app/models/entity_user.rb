class EntityUser < ActiveRecord::Base
  belongs_to :entity
  belongs_to :user
  # TODO: define or remove these boolean fields
  attr_accessor :b_admin, :b_moderator, :b_student, :b_teacher
  
  validates_presence_of :entity
  validates_presence_of :user
  validates_uniqueness_of :user_id, scope: :entity_id
end
