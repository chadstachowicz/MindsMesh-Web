class User < ActiveRecord::Base
  attr_accessible :name, :photo_url, :roles_s
  has_many :logins
  validates_presence_of :name
end
