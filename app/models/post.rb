class Post < ActiveRecord::Base
  belongs_to :section
  belongs_to :user
  belongs_to :section_user
  attr_accessible :text
  validates_presence_of :section
  validates_presence_of :user
  validates_presence_of :section_user
  validates_presence_of :text
  validates_length_of :text, minimum: 10

  before_validation do
    self.user_id    = section_user.user_id
    self.section_id = section_user.section_id    
  end

  #before_validation do
  #  if section_user_id.nil? && section_id.present? && user_id.present?
  #    self.section_user_id = SectionUser.find_by_section_id_and_user_id(section_id, user_id).try :id
  #  elsif section_user_id.present? && user_id.nil? && section_id.nil?
  #    self.user_id = section_user.user_id
  #    self.section_id = section_user.section_id
  #  end
  #end
end
