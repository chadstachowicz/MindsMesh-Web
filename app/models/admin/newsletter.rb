
# MindsMesh, Inc. (c) 2012-2013

class Admin::Newsletter < ActiveRecord::Base

  has_many :admin_campaigns

  attr_accessible :htmlemail, :plainemail, :status, :title, :element_id, :kind
  
  attr_accessor :get_group

  scope :limited, lambda { |num| { :limit => num } }

  validates_presence_of :title, length: { is: 4 }, :message => "can't be minor to four characters"

  validates_presence_of :htmlemail, length: { is: 20 }, :message => "can't be minor to twenty characters"

  class << self
      def get_group(entities, kind)

        Rails.logger.debug entities.inspect
        if kind == 'user'
            return data = {admin: 'Admin', moderator: 'Moderator', student:'Student'}
        else  
          data = Array.new
        end

        entities.each do |e|
            # Rails.logger.debug "account: #{e}"
            w = {entity_id: e }
            
            if kind == 'group'
              result = Group.where( w )
            else
              result = Topic.where( w )
            end
            # Rails.logger.debug "result: #{result.inspect} \n\n"
            if !result.empty?
              data << result
            end
        end

        return data

      end
  end

end
