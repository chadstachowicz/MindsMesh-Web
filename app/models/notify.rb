class Notify < ActiveRecord::Base
  attr_accessible :target
  belongs_to :target, polymorphic: true
  validates_presence_of :target

  def self.run_all(target_types)
    while n = Notify.where(target_type: target_types).limit(1).first do
      now = Time.now.strftime('%H:%M:%S')
      puts "starting notify #{n.id} at #{now}" unless Rails.env.test?
      n.run
    end
  end

  def run
    #code that creates/updates notifications based on target type
    case target_type
      when Post.name   then run_post
      when Reply.name  then run_reply
      when Like.name   then run_like
    end
    destroy
  end

  def run_post
    topic_user = TopicUser.where(topic_id: target.topic_id, user_id: target.user_id).first
    Notification.notify_users_in_topic_user(topic_user, Notification::ACTION_POSTED, topic_user.user_id)
  end

  def run_reply
    Notification.notify_users_involved_in_post(target.post, Notification::ACTION_REPLIED, target.user_id)
  end

  def run_like
    a_post = target.likable.is_a?(Reply) ? target.likable.post : target.likable
    Notification.notify_users_involved_in_post(a_post, Notification::ACTION_LIKED, target.user_id)
  end


=begin
    api = Koala::Facebook::API.new
    results = @api.batch do |batch_api|
                batch_api.get_object('me')
                batch_api.get_connections(@app_id, 'insights', {}, {"access_token" => @app_api.access_token})
              end
=end
end