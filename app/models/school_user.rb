class SchoolUser < ActiveRecord::Base
  belongs_to :school
  belongs_to :user
  attr_accessible :b_admin, :b_moderator, :b_student, :b_teacher
  
  validates_presence_of :school
  validates_presence_of :user
  validates_uniqueness_of :user_id, scope: :school_id
end
