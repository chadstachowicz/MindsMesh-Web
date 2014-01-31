class LoginLog < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_agent

  validates_presence_of :user
  validates_presence_of :user_agent
end
