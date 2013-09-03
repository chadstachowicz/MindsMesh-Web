require 'resque'

module RetriedJob
    def on_failure_retry(e, *args)
        puts "Performing #{self} caused an exception (#{e}). Retrying..."
        $stdout.flush
        Resque.enqueue self, *args
    end
end

class ImportTopics

    extend RetriedJob
    @queue = :notify
    
 def self.perform(chunk)
    chunk.each do |i|
        i.symbolize_keys!
        @topic = Topic.where(:number => i[:number]).first_or_initialize
        @topic.title = i[:number]
        @topic.entity_id = i[:entity_id]
    end

 end

end