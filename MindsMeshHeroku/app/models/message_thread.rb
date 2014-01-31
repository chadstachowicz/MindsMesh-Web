class MessageThread < ActiveRecord::Base
    attr_accessible :user_id
    belongs_to :messages
    belongs_to :thread_participants
end
