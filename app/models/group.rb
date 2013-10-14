class Group < ActiveRecord::Base
    attr_accessible :description, :entity_user_id, :group_users_count, :name, :posts_count, :slug, :user_id, :privacy
    
    belongs_to :entity, counter_cache: true
    belongs_to :user
    has_many :group_users, dependent: :destroy
    has_many :posts,       dependent: :destroy
    has_many :users, through: :group_users
    has_many :invite_requests, dependent: :destroy
    
    validates_presence_of :name
    
    attr_accessor :entity_user, :entity_user_id
    before_validation :set_entity_user_correctly, on: :create
    
    def entity_user_join(entity_user1,admin=false)
        raise 'nil argument' if entity_user1.nil?
        gu = group_users.where(user_id: entity_user1.user.id).first_or_initialize
        if admin
            gu.role_i = 1
        end
        gu.save
        
    end
    
    def entity_user_leave(entity_user1)
        raise 'nil argument' if entity_user1.nil?
        group_users.where(user_id: entity_user1.user.id).first_or_initialize.destroy
    end
    
    def set_entity_user_correctly
        if entity_user_id
            self.entity_user=EntityUser.find(entity_user_id)
        end
        if entity_user
            self.entity  = entity_user.entity
            self.user    = entity_user.user
        end
    end

end
