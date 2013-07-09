class PostHashtag < ActiveRecord::Base
  attr_accessible :hashtag_id, :post_id
    belongs_to :hastag
    belongs_to :post
end
