class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  belongs_to :entity
  has_many :topic_users
  has_many :posts
  attr_accessible :name, :slug, :entity_id
  validates_presence_of :name
  validates_presence_of :slug
  validates_presence_of :entity

  before_validation :slugify

  def slugify
  	self.slug = name.parameterize if self.slug.blank?
  end

end
