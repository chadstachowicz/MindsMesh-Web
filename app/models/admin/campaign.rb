
# MindsMesh, Inc. (c) 2012-2013

class Admin::Campaign < ActiveRecord::Base

  belongs_to :newsletter

  attr_accessible :kind, :element_id, :historic, :newsletter_id

end
