class Topic < ActiveRecord::Base
  belongs_to :entity
  has_many :topic_users
  has_many :posts
  attr_accessible :name, :slug, :entity_id
  validates_presence_of :name
  validates_presence_of :entity
end
