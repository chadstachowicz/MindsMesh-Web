class GroupUser < ActiveRecord::Base
    belongs_to :group, counter_cache: true
    belongs_to :user, counter_cache: true
    
    attr_accessible :group_id, :group_user_id, :role_i
    
    validates_presence_of :group
    validates_presence_of :user
    validates_presence_of :group_user, on: :creation
    validates_uniqueness_of :user_id, scope: :group_id
    
end
