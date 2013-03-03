require 'resque'

module RetriedJob
    def on_failure_retry(e, *args)
        puts "Performing #{self} caused an exception (#{e}). Retrying..."
        $stdout.flush
        Resque.enqueue self, *args
    end
end

class LoginContinue
    extend RetriedJob
    
    @queue = :facebook
    
 def self.perform(user_id)
    puts "-"*60
    user = User.find user_id
    user.store_fb_friends!
 end
end