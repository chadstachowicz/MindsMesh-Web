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
    self.text = if target.respond_to?(:text)
      target.text[0..60]
    else
      target.name[0..60]
    end
  end

  def mark_as_read
  	self.b_read = true
    delete_fb_apprequest
    save!
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
  def self.notify_users_involved_in_post(post_id, action)
    post = Post.find(post_id) rescue nil
    if post
      new_actors_count = (action == ACTION_REPLIED) ? post.replies.size : post.likes.size
      User.find(post.user_ids_involved).each do |user|
        notify_user(user, post, action, new_actors_count)
=begin
        n = where(target_type: post.class.name, target_id: post.id, action: action).first_or_initialize(user: user)
        n.b_read = false
        n.actors_count = new_actors_count
        n.save!
        n.notify_on_facebook!
=end
      end
    end
  end

  def self.notify_users_in_topic(topic_id, action)
    topic = Topic.find(topic_id) rescue nil
    if topic
      new_actors_count = topic.posts.where('created_at > ?', 3.day.ago).count
      topic.users.each do |user|
        notify_user(user, topic, action, new_actors_count)
=begin
        n = where(target_type: topic.class.name, target_id: topic.id, action: action).first_or_initialize(user: user)
        n.b_read = false
        n.actors_count = new_actors_count
        n.save!
        n.notify_on_facebook!
=end
      end
    end
  end

  def self.notify_user(user, target, action, new_actors_count)
    n = where(target_type: target.class.name, target_id: target.id, action: action).first_or_initialize(user: user)
    n.b_read = false
    n.actors_count = new_actors_count
    n.save!
    n.notify_on_facebook!
  end

  def notify_on_facebook!

    if Rails.env.production?
      raise "notification must be saved to invoke this method" if new_record?
      delete_fb_apprequest
      post_fb_apprequest
    else
      @api_returned_hash = {"request"=>rand(999), "to"=>["123"]}
    end
    
    set_fb_apprequest_id(@api_returned_hash)
    logger.info "FB_GRAPH_API: post apprequest ok: id = #{id} fb: #{fb_apprequest_id}"
    save!
  end

  def set_fb_apprequest_id(h)
    self.fb_apprequest_id = "#{h['request']}_#{h['to'].first}"
  end

  private

  def delete_fb_apprequest
    if Rails.env.production? && fb_apprequest_id.present?
      begin
        target.user.fb_api.delete_object(fb_apprequest_id)
        logger.info "FB_GRAPH_API: delete apprequest ok: #{fb_apprequest_id}" 
      rescue Exception => exc
        logger.info "FB_GRAPH_API: delete apprequest error: #{exc.message}"
      end
    end
    self.fb_apprequest_id = nil
  end

  def post_fb_apprequest
    begin
      @api_returned_hash = target.user.fb_api.put_connections('me', 'apprequests', message: facebook_message, data: id)
    rescue Exception => exc
      logger.info "FB_GRAPH_API: post apprequest error: #{exc.message}"
    end
  end
end
