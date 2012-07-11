class Entity < ActiveRecord::Base

  attr_accessible :name, :slug, :self_joining

  has_many :entity_user_requests, dependent: :destroy
  has_many :entity_users, 		  dependent: :destroy
  has_many :topics, 			  dependent: :destroy
  validates_presence_of :name

  scope :non_self_joinings, where(self_joining: false)
  scope :self_joinings,     where(self_joining: true)

  def user_join!(user)
    transaction do
      entity_users.create! user: user
      user.roles += ['client']
      user.save!
    end
  end
end
