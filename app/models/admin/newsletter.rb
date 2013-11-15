
# MindsMesh, Inc. (c) 2012-2013

class Admin::Newsletter < ActiveRecord::Base

  has_many :admin_campaigns

  attr_accessible :htmlemail, :plainemail, :status, :title
  
  attr_accessor :get_group

  scope :limited, lambda { |num| { :limit => num } }

  validates_presence_of :title, length: { is: 4 }, :message => "can't be minor to four characters"

  validates_presence_of :htmlemail, length: { is: 20 }, :message => "can't be minor to twenty characters"

  class << self
      def get_group(group)
          
          case group
              when 'college' 
                  @data = Entity.find(:all)
                  return @data
              when 'class' 
                  return @data = Topic.find(:all)
              when 'group' 
                  return @data = Group.find(:all) 
              when 'user' 
                  return @data = Array[{name:'Admins', id:1}, {name:'Professors', id:2}, {name:'Students', id:3}, {name:'This is a global mail', id:4}]
              else              
                  return @data = Entity.find(:all)
          end
    end
  end
end
