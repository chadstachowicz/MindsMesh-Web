class ThreadParticipant < ActiveRecord::Base
    attr_accessible :message_thread_id, :user_id
    belongs_to :user
    has_many :message_threads
end
