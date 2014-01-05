class Notification < ActiveRecord::Base

  include ActionView::Helpers::TextHelper

  belongs_to :user
  belongs_to :target, polymorphic: true
  attr_accessible :action, :actors_count, :b_read, :target_id, :target_type, :user, :text
  attr_accessor :api_returned_hash

  validates_presence_of :user
  validates_presence_of :target
  validates_presence_of :action
  # validates_presence_of :text

  # TODO: test this
  scope :sorted, order('updated_at DESC')
  scope :unread, sorted.where(b_read: false)
  scope :read,   sorted.where(b_read: true)


  before_validation do
    self.text = self.text[0..60] unless self.text.blank?
  end

  def facebook_message
    user_name = User.find(user_id).name
    "#{user_name} #{action_as_verb}"
  end

  def push_message_make(id)
    user_name = User.find(id).name
    "#{user_name} #{action_as_verb}"
  end


  def action_as_verb
    action_as_verb_html.gsub('<u>', '"').gsub('</u>', '"')
  end

  def action_as_verb_html
    #case action
    if action == ACTION_POSTED
      "recently posted in <u>#{truncate text, length: 35}</u>"
    elsif action == ACTION_REPLIED
      "replied to <u>#{truncate text, length: 55}</u>"
    elsif action == ACTION_LIKED
      "pinned <u>#{truncate text, length: 40}</u>"
    elsif action == ACTION_INVITED
      "invited you to <u>#{truncate text, length: 40}</u>"
    end
  end

  # TODO: test this
  ACTION_POSTED = 'posted'
  ACTION_INVITED = 'invited'
  ACTION_REPLIED = 'replied'
  ACTION_LIKED = 'liked'
=begin
  #this model is only intended to nofity a target's owner for the time being
  def self.notify_owner(target, action, new_actors_count)
    n = where(target_type: target.class, target_id: target.id, action: action).first_or_initialize(user: target.user)
    n.b_read = false
    n.actors_count = new_actors_count
    n.save!
    n.notify_on_facebook!
  end
=end

  #deprecated
  def self.notify_users_involved_in_post(post, action, ignore_user_id)
    new_actors_count = (action == ACTION_REPLIED) ? post.replies.size : post.likes.size
    user_ids = post.user_ids_involved
    user_ids.delete(ignore_user_id)
    User.find(user_ids).each do |user|
      notify_user!(user, post, action, post.text, new_actors_count)
    end
  end

  #in use by config/jobs.rb
  def self.notify_about_new_reply(reply)
    puts "notify about new reply"
    post = reply.post
    action = ACTION_REPLIED
    ignore_user_id = reply.user_id

    new_actors_count = post.replies_count
    user_ids = ([post.user_id] + post.replies.pluck(:user_id)).uniq

    puts "user_ids: #{user_ids}"
    user_ids.delete(ignore_user_id)
    puts "user_ids to notify: #{user_ids}"
    User.find(user_ids).each do |user|
      n = notify_user!(user, post, action, post.text, new_actors_count,reply.user_id)
      #TODO: unsubscribe
      puts email = user.entity_user_requests.first.email
      MyMail.notify_new_reply(user, post, email).deliver

    end
    true
  end

    def self.notify_invitees(group, action, user_ids, ignore_user_id)
        users = user_ids.split(/,/)
        users.each do |usr|
            notify_user!(User.find(usr.to_i), group, action, group.name)
        end
    end

  def self.notify_users_in_topic(topic, action, ignore_user_id)
    new_actors_count = topic.posts.where('created_at > ?', 3.day.ago).count
    topic.users.each do |user|
      notify_user!(user, topic, action, topic.name, new_actors_count, nil, ignore_user_id) unless user.id == ignore_user_id
    end
  end

  def self.notify_users_in_group(group, action, ignore_user_id)
    new_actors_count = group.posts.where('created_at > ?', 3.day.ago).count
    group.users.each do |user|
      notify_user!(user, group, action, group.name, new_actors_count, nil, ignore_user_id) unless user.id == ignore_user_id
    end
  end

  def self.notify_user!(user, target, action, text, new_actors_count=1, reply_id=nil, post_user_id=nil)
    n = where(user_id: user.id, target_type: target.class.name, target_id: target.id, action: action).first_or_initialize(text: text)
    n.b_read = false
    n.actors_count = new_actors_count
    n.save! #ensure it's persisted
    if !reply_id.nil?
        message = n.push_message_make(reply_id)
    elsif !post_user_id.nil?
        message = n.push_message_make(post_user_id)
    else
        puts "message"
        message = n.facebook_message
    end
        

    #notify mobile devices
    if !user.user_devices.empty?
      user.user_devices.each do |ud|
        n.new_apn(ud.token,ud.environment, ud.os, message)
      end
    end

    if !user.fb_id.nil?
        n.notify_on_facebook #TODO: rescue, log in db
    end
    n
  end

  def new_apn(device_token,environment,os,push_message)
   if environment == 'production'
    if os == 'android'
        options = {:body => {:channel => 'alert', :to_tokens => device_token, :payload => {:alert => push_message, :vibrate => 'true', :notification_id => id, :target_type => target_type, :target_id => target_id}.to_json}}
        response = HTTParty.post('https://api.cloud.appcelerator.com/v1/push_notification/notify_tokens.json?key=NuMqdARV6T9oNDLF3ulcZ4Rt93K7xw1x',options)
     else

      options = {:body => {:channel => 'alert', :to_tokens => device_token, :payload => {:alert => push_message, :notification_id => id, :target_type => target_type, :target_id => target_id}.to_json}}
      response = HTTParty.post('https://api.cloud.appcelerator.com/v1/push_notification/notify_tokens.json?key=AeJdeTWgQfQnDKfeWnPdpKhFH6f0cCgP',options)

     end
    else
     if os == 'android'
      options = {:body => {:channel => 'alert', :to_tokens => device_token, :payload => {:alert => push_message, :vibrate => 'true', :notification_id => id, :target_type => target_type, :target_id => target_id}.to_json}}
      response = HTTParty.post('https://api.cloud.appcelerator.com/v1/push_notification/notify_tokens.json?key=3WikqNv5J3UTkbbBv9IwVTFtSuzXu4rC',options)
     else
      
      options = {:body => {:channel => 'alert', :to_tokens => device_token, :payload => {:alert => push_message, :notification_id => id, :target_type => target_type, :target_id => target_id}.to_json}}
      response = HTTParty.post('https://api.cloud.appcelerator.com/v1/push_notification/notify_tokens.json?key=VqrInB7qyxetHfzNxIKIvzctf6Y3k2U1',options)
      
     end
   end
  end

  def mark_as_read!
    self.b_read = true
    #api_delete_fb_apprequest
    save!
  end
  
  def notify_on_facebook
    unless user.fb_api_expired?
      begin
        user.fb_api.put_connections('me', 'apprequests', message: facebook_message, data: id)
      rescue Koala::Facebook::APIError => e
        puts e.class
        puts e.message
        if e.message.include? 'validating access token'
          user.fb_api_expire!
          puts "Saved. FB Access Token Expired :("
        end
      end
    end
  end
  
  def notify_on_email(email)
  end
=begin
#deprecated, since homes#fb_canvas clears all messages
  def api_delete_fb_apprequest
    raise "must be persisted to invoke this method" if new_record?
    if self.fb_apprequest_id.present?
      begin
        user.fb_api.delete_object(fb_apprequest_id)
        logger.info "FB_GRAPH_API: delete apprequest ok: #{fb_apprequest_id}"
      rescue Exception => exc
        logger.info "FB_GRAPH_API: delete apprequest error: #{exc.message}"
      end
    end
    self.fb_apprequest_id = nil
  end

  def api_post_fb_apprequest
    begin
      h = user.fb_api.put_connections('me', 'apprequests', message: facebook_message, data: id)
      self.fb_apprequest_id = "#{h['request']}_#{h['to'].first}"
      logger.info "FB_GRAPH_API: post apprequest ok: #{fb_apprequest_id}"
    rescue Exception => exc
      logger.info "FB_GRAPH_API: post apprequest error: #{exc.message}"
    end
  end
=end
end