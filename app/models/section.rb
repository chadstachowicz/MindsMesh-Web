class Section < ActiveRecord::Base
  belongs_to :course
  belongs_to :school
  has_many :section_users
  has_many :posts
  attr_accessible :name, :slug, :course_id, :school_id
  validates_presence_of :name
  validates_presence_of :course
  validates_presence_of :school
end
