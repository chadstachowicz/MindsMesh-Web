require 'stalker'
require File.expand_path("../environment", __FILE__)

include Stalker

job 'login.continue' do |args|
  user = User.find args['user_id']
  user.store_fb_friends!
end

job 'facebook.apprequests.clear' do |args|
  @oauth=KoalaFactory.new_oauth
  signed_request = @oauth.parse_signed_request(args['signed_request'])
  puts "signed_request: #{signed_request}"

  @graph = KoalaFactory.new_graph(signed_request["oauth_token"])
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