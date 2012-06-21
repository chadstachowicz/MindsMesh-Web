class Entity < ActiveRecord::Base
  attr_accessible :name, :slug
  has_many :entity_user_requests
  has_many :entity_users
  has_many :topics
  validates_presence_of :name
end
