
# MindsMesh (c) 2013

require 'stalker'

require File.expand_path("../../config/environment", __FILE__)

include Stalker

job 'notify.new.post' do |args|

end

job 'notify.new.reply' do |args|
  
end

#people could only like post when this script was written
job 'notify.new.like' do |args|
  puts "-"*60
  like = Like.find(args['id'])
  a_post = like.likable
  Notification.notify_users_involved_in_post(a_post, Notification::ACTION_LIKED, like.user_id)
end
