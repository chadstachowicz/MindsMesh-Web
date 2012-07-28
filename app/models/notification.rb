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
    "#{pluralize(actors_count, 'person')} #{action_as_verb}"
  end

  def action_as_verb
    action_as_verb_html.gsub('<u>', '"').gsub('</u>', '"')
  end

  def action_as_verb_html
    #case action
    if action == ACTION_POSTED
      "posts in <u>#{truncate text, length: 35}</u> in the last 3 days"
    elsif action == ACTION_REPLIED
      "replied to <u>#{truncate text, length: 55}</u>"
    elsif action == ACTION_LIKED
      "thought <u>#{truncate text, length: 40}</u> was intelligent"
    end
  end

  # TODO: test this
  ACTION_POSTED = 'posted'
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

  def self.notify_users_involved_in_post(post, action, ignore_user_id)
    new_actors_count = (action == ACTION_REPLIED) ? post.replies.size : post.likes.size
    user_ids = post.user_ids_involved
    user_ids.delete(ignore_user_id)
    User.find(user_ids).each do |user|
      notify_user!(user, post, action, post.text, new_actors_count)
    end
  end

  def self.notify_users_in_topic_user(topic_user, action, ignore_user_id)
    topic = topic_user.topic
    new_actors_count = topic.posts.where('created_at > ?', 3.day.ago).count
    topic.users.each do |user|
      notify_user!(user, topic, action, topic.name, new_actors_count) unless user.id == ignore_user_id
    end
  end

  def self.notify_user!(user, target, action, text, new_actors_count)
    n = where(target_type: target.class.name, target_id: target.id, action: action).first_or_initialize(user: user, text: text)
    n.b_read = false
    n.actors_count = new_actors_count
    n.save! #ensure it's persisted
    n.notify_on_facebook!
  end

  def mark_as_read!
    self.b_read = true
    api_delete_fb_apprequest
    save!
  end
  
  def notify_on_facebook!
    api_delete_fb_apprequest
    api_post_fb_apprequest
    save!
  end

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
end
