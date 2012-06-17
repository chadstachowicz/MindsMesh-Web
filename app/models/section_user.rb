class SectionUser < ActiveRecord::Base
  belongs_to :section
  belongs_to :user
  attr_accessible :b_moderator, :b_teacher, :section_id, :user_id
  validates_presence_of :section
  validates_presence_of :user
  validates_uniqueness_of :user_id, scope: :section_id
end
