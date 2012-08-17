class Entity < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  attr_accessible :name, :slug, :self_joining

  has_many :entity_user_requests, dependent: :destroy
  has_many :entity_users, 		  dependent: :destroy
  has_many :topics, 			  dependent: :destroy
  validates_presence_of :name
  validates_presence_of :slug


  before_validation :slugify

  def slugify
    self.slug = name.parameterize if self.slug.blank?
  end

  scope :non_self_joinings, where(self_joining: false)
  scope :self_joinings,     where(self_joining: true)

  def user_join!(user)
    transaction do
      eu = entity_users.create!(user: user)
      user.save!
      return eu
    end
  end
end
