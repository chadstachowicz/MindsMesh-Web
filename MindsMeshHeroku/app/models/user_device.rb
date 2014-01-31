
# MindsMesh, Inc. (c) 2012-2013

class UserDevice < ActiveRecord::Base
  belongs_to :user
  attr_accessible :os, :environment, :model, :name, :token

  validates_presence_of :os
  validates_presence_of :model
  validates_presence_of :name
  validates_presence_of :token

  #always suggest production
  #so we're hardcoding these for the time being
  before_create do
    self.environment = 'production'
  end
end
