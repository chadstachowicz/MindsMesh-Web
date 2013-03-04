require 'resque'

module RetriedJob
    def on_failure_retry(e, *args)
        puts "Performing #{self} caused an exception (#{e}). Retrying..."
        $stdout.flush
        Resque.enqueue self, *args
    end
end

class NotifyNewReply

    
    @queue = :notify 
    
 def self.perform(id)
    puts "-"*60
    reply = Reply.find(id)
    Notification.notify_about_new_reply(reply)
 end
end