
# MindsMesh, Inc. (c) 2012-2013

class Admin::Newsletter < ActiveRecord::Base
    
  attr_accessible :htmlemail, :plainemail, :status, :title

  named_scope :limited, lambda { |num| { :limit => num } }

end
