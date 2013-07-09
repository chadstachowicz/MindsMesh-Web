class Post < ActiveRecord::Base
    belongs_to :topic, counter_cache: true
    belongs_to :group, counter_cache: true
    belongs_to :user, counter_cache: true
    has_many :replies, dependent: :destroy
    has_many :likes,   dependent: :destroy, as: :likable
    has_many :post_attachments, dependent: :destroy
    has_many :post_hashtags, dependent: :destroy
    has_many :notifications,   dependent: :destroy, as: :target
    has_and_belongs_to_many :hashtags
    
    attr_accessible :text, :topic_user, :topic_id, :user_id, :group_user, :group_id, :topic_user_id
    
    validates_presence_of :user
    

    
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





after_commit :lazy_notify, on: :create

def lazy_notify
    Resque.enqueue(NotifyNewPost, id.to_s) unless Rails.env.test?
end



  def with_links
    text = self.text.gsub(/(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i) { "<a href=\"/hash/#{$1}\"> ##{$1}</a>" }
    Rinku.auto_link(text)
  end

end
