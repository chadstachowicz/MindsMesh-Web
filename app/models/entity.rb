class Entity < ActiveRecord::Base
  attr_accessible :name, :slug
  has_many :entity_user_requests, dependent: :destroy
  has_many :entity_users, 		  dependent: :destroy
  has_many :topics, 			  dependent: :destroy
  validates_presence_of :name
end
