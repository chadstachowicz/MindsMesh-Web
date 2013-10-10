require 'resque'

module RetriedJob
    def on_failure_retry(e, *args)
        puts "Performing #{self} caused an exception (#{e}). Retrying..."
        $stdout.flush
        Resque.enqueue self, *args
    end
end

class NotifyNewInvite

    
    @queue = :notify
    
 def self.perform(group_id, user_id, users)
    puts "-"*60
    group = Group.find(group_id)
    Notification.notify_invitees(group, Notification::ACTION_POSTED, users, user_id)
 end
end