class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  belongs_to :topic_user
  has_many :replies
  attr_accessible :text
  validates_presence_of :topic
  validates_presence_of :user
  validates_presence_of :topic_user
  validates_presence_of :text
  validates_length_of :text, minimum: 10

  before_validation do
    self.user_id    = topic_user.user_id
    self.topic_id = topic_user.topic_id    
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
