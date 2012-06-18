class SectionUser < ActiveRecord::Base
  belongs_to :section
  belongs_to :user
  has_many :posts
  attr_accessible :role, :section_id, :user_id
  validates_presence_of :section
  validates_presence_of :user
  validates_uniqueness_of :user_id, scope: :section_id

  ROLES = ['teacher', 'moderator', nil]
  validates_inclusion_of :role, in: ROLES

  def role_s
    role || "student"
  end
end
