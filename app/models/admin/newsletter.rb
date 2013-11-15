
# MindsMesh, Inc. (c) 2012-2013

class Admin::Newsletter < ActiveRecord::Base

  # has_many :admin_campaigns

  attr_accessible :htmlemail, :plainemail, :status, :title

  scope :limited, lambda { |num| { :limit => num } }

  validates_presence_of :title, length: { is: 4 }, :message => "can't be minor to four characters"

  validates_presence_of :htmlemail, length: { is: 20 }, :message => "can't be minor to twenty characters"

  def get_group(group) 
    @group = group
    case group
        when 'college' 
            return @data = Entity.find(:all)
        when 'class' 
            puts 'n is a perfect square'
        when 'group' 
            return @data = Group.find(:all) 
        when 'user' 
            return @data = User.find(:all)
        else              
            return @data = Entity.find(:all)
    end
  end
end
