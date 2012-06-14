class School < ActiveRecord::Base
  attr_accessible :name, :slug
  has_many :school_user_requests
end
