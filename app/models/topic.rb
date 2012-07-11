class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  attr_accessible :name, :slug, :entity_id, :self_joining

  belongs_to :entity
  has_many :topic_users, dependent: :destroy
  has_many :posts,       dependent: :destroy

  validates_presence_of :name
  validates_presence_of :slug
  validates_presence_of :entity

  scope :non_self_joinings, where(self_joining: false)
  scope :self_joinings,     where(self_joining: true)

  def user_join(user)
    topic_users.where(user_id: user.id).first_or_create
  end


  before_validation :slugify

  def slugify
  	self.slug = name.parameterize if self.slug.blank?
  end

end
