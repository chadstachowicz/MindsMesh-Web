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
    @queue = :import
    
 def self.perform(chunk, jobid)
     @job = BackgroundJob.find(jobid)
    chunk.each do |i|
        @job.transactions = @job.transactions.to_i + 1
        i.symbolize_keys!
        @topic = Topic.find_by_number(i[:course_number])
        @roster = Roster.where(:topic_id => @topic.id, :email => i[:email]).first_or_initialize
        if i[:role] == 1
            @roster.role = 1
        end
        @roster.save
        if @job.transactions == @job.total_records
            @job.status = "Complete"
        end
        @job.save
    end

 end

end