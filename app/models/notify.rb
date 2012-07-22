class Notify < ActiveRecord::Base
  attr_accessible :target
  belongs_to :target, polymorphic: true
  validates_presence_of :target

  def self.run_all(target_types)
    while n = Notify.where(target_type: target_types).limit(1).first do
      puts "starting notify #{n.id}" unless Rails.env.test?
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
    Notification.notify_users_in_topic(target.topic_id, Notification::ACTION_POSTED, target.user_id)
  end

  def run_reply
    Notification.notify_users_involved_in_post(target.post_id, Notification::ACTION_REPLIED, target.user_id)
  end

  def run_like
    a_post_id = target.likable.is_a?(Reply) ? target.likable.post_id : target.likable.id
    Notification.notify_users_involved_in_post(a_post_id, Notification::ACTION_LIKED, target.user_id)
  end


=begin
    api = Koala::Facebook::API.new
    results = @api.batch do |batch_api|
                batch_api.get_object('me')
                batch_api.get_connections(@app_id, 'insights', {}, {"access_token" => @app_api.access_token})
              end
=end
end