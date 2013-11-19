
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
        
        users = {admin: 'Admin', moderator: 'Moderator', student:'Student'}

        data = Array.new
        #data << {kind: kind}
        
        ents = Entity.find(entities, :select => "id,name")
        
        Rails.logger.debug "Ents:  #{kind} \n \n"
        #raise 
        ents.each do |e|
            Rails.logger.debug "entity: #{e.inspect}"

            entity = {name:e.name, id: e.id}

            case kind
                when 'users'
                    entity[:users] = users

                when 'groups'
                    groups = Group.where(entity_id:e.id).select("id,name")

                    if !groups.empty?
                        entity[:groups] = groups
                    end
                    
                when 'topics'
                    topics = Topic.where(entity_id:e.id).select("id,name")
                    if !topics.empty?
                        entity[:topics] = topics 
                    end
            end
          
            # Rails.logger.debug "result: #{result.inspect} \n\n"
            data << entity    
        end

        return data

      end
  end

end
