class Post < ActiveRecord::Base
  belongs_to :topic, counter_cache: true
  belongs_to :user, counter_cache: true
  has_many :replies, dependent: :destroy
  has_many :likes,   dependent: :destroy, as: :likable
  has_many :post_attachments, dependent: :destroy

  attr_accessible :text, :topic_user, :topic_user_id
  validates_presence_of :topic
  validates_presence_of :user
  validates_presence_of :text
  validates_length_of :text, minimum: 10

  after_create :lazy_notify

  #scope :includes_all , includes(:user, :topic, :replies, :likes)
  class << self
    def before(id)
      id ? where("posts.id < ?", id) : scoped
    end

    def as_feed(options={})
      options = options.reverse_merge(limit: 10)
      order("id DESC").limit(options[:limit]).before(options[:before])
    end
  end

  def user_liked?(user)
    likes.exists?(user_id: user.id)
  end

  def user_ids_involved
    @user_ids_involved ||= [
      user_id,
      likes.pluck(:user_id),
      replies.pluck(:user_id),
      replies.map { |r| r.likes.pluck(:user_id) }
    ].flatten.uniq
  end




  attr_accessor :topic_user, :topic_user_id
  before_validation :set_topic_user_correctly, on: :create

  def set_topic_user_correctly
    if topic_user_id
      self.topic_user=TopicUser.find(topic_user_id)
    end
    if topic_user
      self.topic  = topic_user.topic
      self.user   = topic_user.user
    end
  end







  def lazy_notify
    Notify.create(target: self) unless Rails.env.test?
  end

end
