class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :replies
  has_many :likes, as: :likable
  attr_accessible :text
  validates_presence_of :topic
  validates_presence_of :user
  validates_presence_of :text
  validates_length_of :text, minimum: 10

  def self.create_with!(topic_user, attrs)
    Post.create!(attrs) do |p|
      p.topic = topic_user.topic
      p.user  = topic_user.user
    end
  end

  default_scope includes(:user)

  def self.before(id)
    id ? where("posts.id < ?", id) : scoped
  end

  def self.as_feed(options={})
    options = options.reverse_merge(limit: 10)
    order("id DESC").limit(options[:limit]).before(options[:before])
  end
end
