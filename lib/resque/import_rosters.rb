require 'resque'

module RetriedJob
    def on_failure_retry(e, *args)
        puts "Performing #{self} caused an exception (#{e}). Retrying..."
        $stdout.flush
        Resque.enqueue self, *args
    end
end

class ImportRosters

    extend RetriedJob
    @queue = :notify
    
 def self.perform(chunk)
    @user = nil
    chunk.each do |i|
        i.symbolize_keys!
        @topic = Topic.find_by_number(i[:course_name])
        @roster = Roster.where(:topic_id => @topic.id, :email => i[:email]).first_or_initialize
    end

 end

end