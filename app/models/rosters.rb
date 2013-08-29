class Rosters < ActiveRecord::Base
  attr_accessible :email, :group_id, :topic_id, :user_id
end
