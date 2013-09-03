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
    @queue = :import
    
 def self.perform(chunk, jobid)
       @job = BackgroundJob.find(jobid)
    chunk.each do |i|
        @job.transactions = @job.transactions.to_i + 1
        i.symbolize_keys!
        @topic = Topic.where(:number => i[:number]).first_or_initialize
        @topic.title = i[:title]
        @topic.entity_id = i[:entity_id]
        @topic.save
        if @job.transactions == @job.total_records
            @job.status = "Complete"
        end
        @job.save
    end

 end

end