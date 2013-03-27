class Message < ActiveRecord::Base
  belongs_to :user
  has_many :message_attachments, dependent: :destroy
  attr_accessible :expiration_date, :expired, :receiver_fb_id, :receiver_id, :replies_count, :text, :user_id
    
    validates_presence_of :user, :text
    
end
