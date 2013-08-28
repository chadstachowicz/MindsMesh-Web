require 'resque'

module RetriedJob
    def on_failure_retry(e, *args)
        puts "Performing #{self} caused an exception (#{e}). Retrying..."
        $stdout.flush
        Resque.enqueue self, *args
    end
end

class ImportUsers

    
    @queue = :notify 
    
 def self.perform(chunk)
    chunk.each do |i|
    puts i[:email]
    user = User.where(:email => i[:email]).first_or_initialize
    user.name = i[:name]
    puts "Start: #{user.email}"
    puts "ID: #{user.id}"
    puts "Start: #{user.name}"
    #  if user.save
    #   entity = Entity.find_by_email_domain(i[:email])
    #    eur = EntityUser.where(:entity_id => entity.id, :user_id => user.id).first_or_initialize
    #        if eur.save
    #            puts "Start: BLARGITY End"
    #            topic = Topic.where(:number => i[:course_number]).first_or_initialize
    ###                eu = TopicUser.where(:topic_id => topic.id, :user_id => user.id, :role_i => 1).first_or_initialize
    #          else
    #                eu = TopicUser.where(:topic_id => topic.id, :user_id => user.id).first_or_initialize
    #            end
    #        eu.save
    #        end
    #    end
    end
 end

end