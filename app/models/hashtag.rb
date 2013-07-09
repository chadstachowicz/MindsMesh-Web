class Hashtag < ActiveRecord::Base
  attr_accessible :entity_id, :name
  has_many :post_hashtags,         dependent: :destroy
  belongs_to :entity
  has_and_belongs_to_many :posts
    
    def posts_feed(options={})
        topic_ids = topic_users.map(&:topic_id)
        group_ids = group_users.map(&:group_id)
        follow_ids = follow_ids(&:follows)
        follow_ids << self.id
        Post.where('(user_id in (:follow_ids) and topic_id is null and group_id is null) or topic_id in (:topic_ids) or group_id in (:group_ids)', :follow_ids => follow_ids, :topic_ids => topic_ids,:group_ids => group_ids).as_feed(options)
    end
    
end
