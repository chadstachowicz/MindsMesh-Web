class Post < ActiveRecord::Base
  belongs_to :topic, counter_cache: true
  belongs_to :user, counter_cache: true
  has_many :replies, dependent: :destroy
  has_many :likes,   dependent: :destroy, as: :likable
  attr_accessible :text
  validates_presence_of :topic
  validates_presence_of :user
  validates_presence_of :text
  validates_length_of :text, minimum: 10

  #scope :includes_all , includes(:user, :topic, :replies, :likes)
  class << self
    def create_with!(topic_user, attrs)
      Post.create!(attrs) do |p|
        p.topic = topic_user.topic
        p.user  = topic_user.user
      end
    end

    def before(id)
      id ? where("posts.id < ?", id) : scoped
    end

    def as_feed(options={})
      options = options.reverse_merge(limit: 10)
      order("id DESC").limit(options[:limit]).before(options[:before])
    end
  end

  def user_ids_involved
    @user_ids_involved ||= [
      user_id,
      likes.pluck(:user_id),
      replies.pluck(:user_id),
      replies.map { |r| r.likes.pluck(:user_id) }
    ].flatten.uniq
  end

  after_create do
    Notification.notify_users_in_topic(
      topic,
      Notification::ACTION_POSTED,
      topic.posts.where('created_at > ?', 3.day.ago).count
    )
  end

end
