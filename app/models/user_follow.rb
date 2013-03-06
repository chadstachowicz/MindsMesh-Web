class UserFollow < ActiveRecord::Base
  attr_accessible :user_id, :follow_id
  belongs_to :user
  belongs_to :follow, :class_name => "User", :foreign_key =>'follow_id'
end
