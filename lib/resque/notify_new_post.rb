require 'resque'

module RetriedJob
    def on_failure_retry(e, *args)
        puts "Performing #{self} caused an exception (#{e}). Retrying..."
        $stdout.flush
        Resque.enqueue self, *args
    end
end

class NotifyNewPost

    
    @queue = :notify
    
 def self.perform(id)
    puts "-"*60
    post = Post.find(id)
    Notification.notify_users_in_topic(post.topic, Notification::ACTION_POSTED, post.user_id)
 end
end