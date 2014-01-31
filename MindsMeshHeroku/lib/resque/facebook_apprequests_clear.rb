require 'resque'

module RetriedJob
    def on_failure_retry(e, *args)
        puts "Performing #{self} caused an exception (#{e}). Retrying..."
        $stdout.flush
        Resque.enqueue self, *args
    end
end

class FacebookApprequestsClear
    
    @queue = :facebook
    
 def self.perform(signed_req, user_id)
    puts "-"*60
    if signed_req
    oauth=KoalaFactory.new_oauth
    signed_request = oauth.parse_signed_request(signed_req)
    puts "signed_request: #{signed_request}"
    
    @graph = KoalaFactory.new_graph(signed_request["oauth_token"])
    elsif user_id
    user = User.find(user_id)
    puts "user: #{user.id} - #{user.name}"
    
    @graph = user.fb_api
    else
    raise "invalid args: #{args}"
end
#@graph.is_a? Koala::Facebook::API

me_apprequests = @graph.get_connections('me', 'apprequests', fields: 'id')
puts "me_apprequests: #{me_apprequests}"

#/me/apprequests?fields=id
# me_apprequests =
# [
#   {"id" => "511851122160218_1307529248"},
#   {"id" => "262637480505316_1307529248"},
#   {"id" => "430167420352703_1307529248"}
# ]

@graph.batch do |batch_api|
    me_apprequests.each do |data|
        batch_api.delete_object(data['id'])
    end
end
end
end