require 'resque'

module RetriedJob
    def on_failure_retry(e, *args)
        puts "Performing #{self} caused an exception (#{e}). Retrying..."
        $stdout.flush
        Resque.enqueue self, *args
    end
end

class ImportUsers

    extend RetriedJob
    @queue = :notify 
    
 def self.perform(chunk)
    @user = nil
    chunk.each do |i|
        i.symbolize_keys!
        @user = User.find_by_email(i[:email])
        @user.name = i[:name]
        puts @user.name
        if @user.save
            entity = Entity.find_by_email_domain(@user.email)
            eur = EntityUser.where(:entity_id => entity.id, :user_id => @user.id).first_or_initialize
            if eur.save
                topic = Topic.where(:number => i[:course_number]).first_or_initialize
                eu = TopicUser.where(:topic_id => topic.id, :user_id => @user.id, :role_i => 1).first_or_initialize
            else
                eu = TopicUser.where(:topic_id => topic.id, :user_id => @user.id).first_or_initialize
            end
        eu.save
        end
    end

 end

end