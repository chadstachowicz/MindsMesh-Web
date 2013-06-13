class MessageReadState < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  attr_accessible :user_id, :message_id, :read_date
    
    
end
