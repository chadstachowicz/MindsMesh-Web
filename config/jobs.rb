require 'stalker'
require File.expand_path("../environment", __FILE__)

include Stalker



job 'login.continue' do |args|
  user = User.find args['user_id']
  user.store_fb_friends!
end