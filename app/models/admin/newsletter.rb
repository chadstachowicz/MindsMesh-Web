
# MindsMesh, Inc. (c) 2012-2013

class Admin::Newsletter < ActiveRecord::Base

  attr_accessible :htmlemail, :plainemail, :status, :title

  scope :limited, lambda { |num| { :limit => num } }

  validates_presence_of :title, length: { is: 4 }, :message => "can't be minor to four characters"

  validates_presence_of :htmlemail, length: { is: 20 }, :message => "can't be minor to twenty characters"

end
