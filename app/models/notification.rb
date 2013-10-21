class Notification < ActiveRecord::Base

  include ActionView::Helpers::TextHelper

  belongs_to :user
  belongs_to :target, polymorphic: true
  attr_accessible :action, :actors_count, :b_read, :target_id, :target_type, :user, :text
  attr_accessor :api_returned_hash

  validates_presence_of :user
  validates_presence_of :target
  validates_presence_of :action
  validates_presence_of :text

  # TODO: test this
  scope :sorted, order('updated_at DESC')
  scope :unread, sorted.where(b_read: false)
  scope :read,   sorted.where(b_read: true)


  before_validation do
    self.text = self.text[0..60] unless self.text.blank?
  end

  def facebook_message
    user_name = User.find(user_id)
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
      n = notify_user!(user, post, action, post.text, new_actors_count)
      #TODO: unsubscribe
      puts email = user.entity_user_requests.first.email
      MyMail.notify_new_reply(user, post, email).deliver

      #notify mobile devices
      user.user_devices.each do |ud|
        n.new_apn(ud.token,ud.environment)
      end
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
      notify_user!(user, topic, action, topic.name, new_actors_count) unless user.id == ignore_user_id
    end
  end

  def self.notify_user!(user, target, action, text, new_actors_count=1)
    n = where(user_id: user.id, target_type: target.class.name, target_id: target.id, action: action).first_or_initialize(text: text)
    n.b_read = false
    n.actors_count = new_actors_count
    n.save! #ensure it's persisted
    if !user.fb_id.nil?
        n.notify_on_facebook #TODO: rescue, log in db
    end
    n
  end

  def new_apn(device_token,environment)
    n = Rapns::Apns::Notification.new
    if environment == 'production'
        n.app = Rapns::Apns::App.find_by_name("ios_app_production")
    else
        n.app = Rapns::Apns::App.find_by_name("ios_app_development")
    end
    n.device_token = device_token
    n.alert = facebook_message
    n.sound = "1.aiff"
    n.expiry = 1.day.to_i
    n.attributes_for_device = {
        :notification_id => id,
        :target_type =>      target_type,
        :target_id    =>    target_id
    }
    n.save!
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