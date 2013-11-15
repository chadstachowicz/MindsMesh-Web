
# MindsMesh, Inc. (c) 2012-2013

class Admin::Campaign < ActiveRecord::Base

  belongs_to :newsletter

  attr_accessible :group, :historic, :value

end
